//
//  OCViewController.m
//  EventDispatch
//
//  Created by redye.hu on 2017/11/9.
//  Copyright © 2017年 redye.hu. All rights reserved.
//

#import "OCViewController.h"
#import <RCTBundleURLProvider.h>
#import <RCTRootView.h>

@interface OCViewController ()

@end

@implementation OCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"OC => JS";
    
    // 这个页面模拟一个推送接收机制
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"发送通知"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(pushNotification)];
    [self.navigationItem setRightBarButtonItem:rightBarItem];
    
    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:[RNBridgeManager manager].bridge
                                                     moduleName:@"ReceiveEvent"
                                              initialProperties:nil];
    rootView.frame = self.view.bounds;
    
    rootView.backgroundColor = [UIColor whiteColor];
    self.view = rootView;
}

- (void)pushNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:RemotePushDidReceivedNotification
                                                        object:nil
                                                      userInfo:@{
                                                                 @"userInfo": @"双 11 快到了"
                                                                 }];
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
