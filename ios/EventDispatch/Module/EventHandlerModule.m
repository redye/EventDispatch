//
//  EventHandlerModule.m
//  EventDispatch
//
//  Created by redye.hu on 2017/11/8.
//  Copyright © 2017年 redye.hu. All rights reserved.
//

#import "EventHandlerModule.h"

@implementation EventHandlerModule

/**
 * 注意括号里的 module 名字，不是 OC 的字符串，`@#js_name` 会将其转化为字符串
 * 如果写成 @"EventHandler", 则实际为  @"@"EventHandler""， 对应的在 JS 为 @"EventHandler"
 */
RCT_EXPORT_MODULE(EventHandler)


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

@end
