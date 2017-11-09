//
//  EventHandlerModule.h
//  EventDispatch
//
//  Created by redye.hu on 2017/11/8.
//  Copyright © 2017年 redye.hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>


/**
 通过一个 Module 处理从 JS 发起的事件
 */
@interface EventHandlerModule : NSObject<RCTBridgeModule>

@end
