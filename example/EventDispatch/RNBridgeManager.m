//
//  RNBridgeManager.m
//  EventDispatch
//
//  Created by redye.hu on 2017/11/7.
//  Copyright © 2017年 redye.hu. All rights reserved.
//

#import "RNBridgeManager.h"
#import <RCTBundleURLProvider.h>

@interface RNBridgeManager()

@property (nonatomic, strong, readwrite) RCTBridge *bridge;

@end

@implementation RNBridgeManager

+ (instancetype)manager {
    static RNBridgeManager *_manager = Nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[RNBridgeManager alloc] init];
    });
    
    return _manager;
}

- (RCTBridge *)bridge {
    if (!_bridge) {
        
#ifdef DEVELOP_REACT_NATIVE_SWITCH
        NSURL *bundleURL = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"
                                                                          fallbackResource:nil];
#else
        NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"jsbundle"];
#endif
        
        _bridge = [[RCTBridge alloc] initWithBundleURL:bundleURL
                                        moduleProvider:nil
                                         launchOptions:nil];
    }
    return _bridge;
}

@end
