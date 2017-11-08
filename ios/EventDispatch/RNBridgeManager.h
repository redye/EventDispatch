//
//  RNBridgeManager.h
//  EventDispatch
//
//  Created by redye.hu on 2017/11/7.
//  Copyright © 2017年 redye.hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RCTBridge.h>

@interface RNBridgeManager : NSObject

@property (nonatomic, readonly) RCTBridge *bridge;


/**
 单利

 @return 实例对象
 */
+ (instancetype)manager;

@end
