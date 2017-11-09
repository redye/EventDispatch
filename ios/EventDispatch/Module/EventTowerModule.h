//
//  EventTowerModule.h
//  EventDispatch
//
//  Created by redye.hu on 2017/11/9.
//  Copyright © 2017年 redye.hu. All rights reserved.
//

#import <React/RCTEventEmitter.h>

/**
 react-native 对通知发送提供了一个 Module 来处理，开发者只需要继承该 module
 子类对需求进一步解读与处理
 其实这里是通过主动调用 JS 代码，将事件信息传递到 JS 端
 */
@interface EventTowerModule : RCTEventEmitter

@end
