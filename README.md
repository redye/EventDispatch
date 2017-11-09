## React-Native 与原生代码之间的事件传递

熟悉 iOS 的同学都知道，controller 之间的事件传递有多种：

* 代理
* block
* 通知
* KVO

那么 React-Native 与原生之间的事件传递又有哪几种呢？

### 从 JS 到原生
从 JS 到原生代码怎么进行事件传递呢？
> 场景一：先在有一个页面，导航是使用原生的 `UINavigationBar`，页面是使用 JS代码，现在点击页面中一个按钮，要求是改变导航的标题。

从问题中可以看出，这个页面是使用了原生和 JS 两种语言完成的，要解决这个问题，也就是要将这两种语言进行通信：点击 JS 代码中的按钮时，通知原生代码，改变导航标题。那么这两种语言要怎样进行通信呢？

* 通过从原生导出的 Module 进行事件通信，即当点击按钮时，调用该 Module ，让 Module 来处理后续的事件传递。这样，问题就转换到原生代码，处理方式就可以有多种选择了。如果，修改标题之后，你还想知道修改的结果，那么你也可以传递一个回调给原生，将修改的结果传回到 JS。
* 从 JS 发通知给原生，先考察一下这个方法是否可行呢？在我了解到 react-native 中，还没有使用过这种方法，在读到这篇文章的诸位大神中，如果有用到这种方法，还请多加指教，不胜感激。

		/**
 		 * callback 要写在最后面
 		 */
		RCT_EXPORT_METHOD(handleEvent:(NSDictionary *)userInfo callback:(RCTResponseSenderBlock)callback) {
    		NSLog(@"事件信息=====> %@", userInfo);
    		// 切换到主线程，JS 代码是运行在 JS 线程上的
    		dispatch_async(dispatch_get_main_queue(), ^{
        		UIApplication *application = [UIApplication sharedApplication];
        		UINavigationController *navigation = (UINavigationController *)[application keyWindow].rootViewController;
        		NSArray *keys = [userInfo isKindOfClass:[NSDictionary class]] ? userInfo.allKeys : nil;
        		__block BOOL isSuccess = NO;
        		if (keys && keys.count > 0) {
            		NSString *key = [keys firstObject];
            		[navigation.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                		if ([obj isKindOfClass:NSClassFromString(key)]) {
                    		obj.title = [userInfo objectForKey:key];
                    		*stop = YES;
                    		isSuccess = YES;
                		}
            		}];
        		}
        		if (callback) {
            		callback(@[[NSString stringWithFormat:@"修改导航标题%@", isSuccess ? @"成功" : @"失败"]]);
        		}
    		});
		}


### 从原生到 JS
上面讲到的是，主动从 JS 代码到原生代码的事件通信，那么从原生主动到 JS 的通信又有哪几种呢？
> 场景二：假如你的项目中集成了远程推送，当你收到推送的时候，希望在 JS 代码中去处理推送信息（严肃脸：为什么不就在 OC 代码中处理推送？！）。

先思考一下，OC 给 OC 发事件可以有四种方式，这几种方式是否都适合从 OC 发事件到 JS 呢？代理，block 这两种方式都依赖于事件发送方和接收方相互引用的，这显然不适用于两种不同语言交互；通知和 KVO 只需要接收方注册观察者就可以，剩下这两种方式是否可行呢，幸运的是，react-native 在 JS 端提供事件订阅者接收事件，对于通知这种方式是可行的，但是并不提供 KVO 方式来观察某一个属性值的变化。所以最终采取的方法是使用 **通知** 将事件信息发送到 JS 端。

在 react-native 的代码库里，对通知发送提供了一个 Module 来处理，开发者只需要继承该 module，子类对需求进一步解读与处理，其实这里是通过主动调用 JS 代码，将事件信息传递到 JS 端。核心方法是 

	/**
 	 * Send an event that does not relate to a specific view, e.g. a navigation
 	 * or data update notification.
 	 */
	- (void)sendEventWithName:(NSString *)name body:(id)body;


JS 代码里需要先初始化一个订阅者

	// 初始化一个订阅者
	const subscription = new NativeEventEmitter(app.EventTower);

添加监听，一定要记得移除哦😊

	// 监听事件
  	_addListener = () => {
    	this.remoteEmitter = subscription.addListener('remotePushDidReceivedEmitter', (userInfo) => {
      		console.log('接收到从原生发来的通知 ==>', userInfo);
      		let count = this.state.count + 1;
      		this.setState({
        		count: count
      		});
    	});
  	}

  	// 移除监听
  	_removeListener = () => {
    	console.log('移除监听');
    	// 移除方式有多种
    	// this.remoteEmitter && this.remoteEmitter.remove();

    	// subscription.removeAllListeners("remotePushDidReceivedEmitter");

    	subscription.removeListener('removeListener', this.remoteEmitter);
  	}

### 从 JS 到 JS
说过了从 JS  => OC，OC => JS，OC => OC， 就差 JS => JS 了。对于一种语言内部的事件传递，肯定实现方式会有多种的，我对 JS 的很多用法也不甚了解，这里就只说下 JS 里面的“通知”机制。
> 使用场景：适用于页面层次比较多，或者页面关联不是很紧密的情况。

	_addListener = () => {
    	// 接收 JS 通知
    	this.subscription = DeviceEventEmitter.addListener("TitleWillChangEmitter", (userInfo) => {
      		console.log('接收到来自 JS 的通知======>', userInfo);
      		this._onPress(null, userInfo.title ? userInfo.title : "小跳蛙");
    	});
 	 }

 	 _removeListener = () => {
    	console.log('移除监听');
    	this.subscription && this.subscription.remove();
  	}

### 事件传递使用
众所周知，使用通知是比较耗费性能的，不管是在原生语言中，还是 JS 与原生语言的通信中，有些场景无法避免要使用到，但是用的时候还是要注意适量。