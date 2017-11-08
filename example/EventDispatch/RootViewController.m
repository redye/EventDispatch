//
//  ViewController.m
//  EventDispatch
//
//  Created by redye.hu on 2017/11/7.
//  Copyright © 2017年 redye.hu. All rights reserved.
//

#import "RootViewController.h"
#import <RCTBundleURLProvider.h>
#import <RCTRootView.h>

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Home";

    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:[RNBridgeManager manager].bridge
                                                     moduleName:@"EventDispatch"
                                              initialProperties:nil];
    rootView.frame = self.view.bounds;
    
    rootView.backgroundColor = [UIColor whiteColor];
    self.view = rootView;
}

- (void)addObservers {
    
}

- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc {
    [self removeObservers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
