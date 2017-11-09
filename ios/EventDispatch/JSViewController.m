//
//  JSViewController.m
//  EventDispatch
//
//  Created by redye.hu on 2017/11/9.
//  Copyright © 2017年 redye.hu. All rights reserved.
//

#import "JSViewController.h"
#import "JSEventViewController.h"
#import <RCTBundleURLProvider.h>
#import <RCTRootView.h>

@interface JSViewController ()

@end

@implementation JSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"JS => OC";
    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:[RNBridgeManager manager].bridge
                                                     moduleName:@"SendEvent"
                                              initialProperties:nil];
    rootView.frame = self.view.bounds;
    
    rootView.backgroundColor = [UIColor whiteColor];
    self.view = rootView;
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"NextPage"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(nextPage)];
    [self.navigationItem setRightBarButtonItem:rightBarItem];
}

- (void)nextPage {
    JSEventViewController *jsEventController = [[JSEventViewController alloc] init];
    [self.navigationController pushViewController:jsEventController animated:YES];
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
