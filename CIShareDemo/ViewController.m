//
//  ViewController.m
//  CIShareSDK
//
//  Created by zhao on 14-5-11.
//  Copyright (c) 2014年 zhao. All rights reserved.
//

#import "ViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "CIShare.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 40);
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = [UIColor whiteColor];
    btn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:btn];
}
- (void)click
{
    [[CIShare sharedInstance] makeShareContent:@"下载得大奖" defaultConent:nil title:@"开火" jumpUrl:@"www.comein.cn" description:nil];
    [[CIShare sharedInstance] addWXChatWithShareHandler:^{
        NSLog(@"微信分享成功");
    } shareFailed:^(id<ICMErrorInfo> error) {
        NSLog(@"微信分享失败");
    }];
    [[CIShare sharedInstance] addRenrenWithShareHandler:^{
        NSLog(@"人人分享成功");
    } shareFailed:^(id<ICMErrorInfo> error) {
        NSLog(@"%@",[error errorDescription]);
        NSLog(@"人人分享失败");
    }];
    
    [[CIShare sharedInstance] addQQWithShareHandler:^{
        NSLog(@"QQ分享成功");
    } shareFailed:^(id<ICMErrorInfo> error) {
        NSLog(@"%@",[error errorDescription]);
        NSLog(@"QQ分享失败");
    }];
    [[CIShare sharedInstance] addQQSpaceWithShareHandler:^{
        NSLog(@"QQ分享成功");
    } shareFailed:^(id<ICMErrorInfo> error) {
        NSLog(@"%@",[error errorDescription]);
        NSLog(@"QQ分享失败");
    }];
    
    [[CIShare sharedInstance] showShareItems];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
