//
//  JSEventViewController.m
//  EventDispatch
//
//  Created by redye.hu on 2017/11/9.
//  Copyright © 2017年 redye.hu. All rights reserved.
//

#import "JSEventViewController.h"
#import <RCTBundleURLProvider.h>
#import <RCTRootView.h>

@interface JSEventViewController ()

@end

@implementation JSEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"JS => JS";
    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:[RNBridgeManager manager].bridge
                                                     moduleName:@"Emitter"
                                              initialProperties:nil];
    rootView.frame = self.view.bounds;
    
    rootView.backgroundColor = [UIColor whiteColor];
    self.view = rootView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
