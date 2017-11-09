//
//  EventTowerModule.m
//  EventDispatch
//
//  Created by redye.hu on 2017/11/9.
//  Copyright © 2017年 redye.hu. All rights reserved.
//

#import "EventTowerModule.h"

@implementation EventTowerModule

RCT_EXPORT_MODULE(EventTower)


///////////////////////////////////////////////////////////////////////////
/// 注意这三个方法是必须实现的

/**
 指定支持的事件，这里的事件名称对应 JS 里面订阅者对应的事件名称
 */
- (NSArray<NSString *> *)supportedEvents
{
    return @[@"remotePushDidReceivedEmitter"
             ];
}

- (void)startObserving {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceivedRemotePush:)
                                                 name:RemotePushDidReceivedNotification
                                               object:nil];
}

- (void)stopObserving {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
///////////////////////////////////////////////////////////////////////////

- (void)didReceivedRemotePush:(NSNotification *)notification {
    [self sendEventWithName:@"remotePushDidReceivedEmitter" body:notification.userInfo];
}


@end
