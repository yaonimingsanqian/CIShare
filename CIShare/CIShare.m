//
//  CIShare.m
//  CIShareDemo
//
//  Created by zhao on 14-5-12.
//  Copyright (c) 2014年 zhao. All rights reserved.
//

#import "CIShare.h"
#import "SharedInstanceGCD.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
@implementation CIShare

@synthesize wxAppId = _wxAppId;
SHARED_INSTANCE_GCD_USING_BLOCK(^{
    return [[self alloc]init];
})
- (id)init
{
    self = [super init];
    if(self)
    {
        shareItems = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)registerApp:(NSString *)appId
{
    [ShareSDK registerApp:appId];
}
- (void)setQqAppId:(NSString *)qqAppId
{
    _qqAppId = qqAppId;
    [ShareSDK connectQQWithQZoneAppKey:qqAppId                 //该参数填入申请的QQ AppId
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
}
- (void)setWxAppId:(NSString *)wxAppId
{
    _wxAppId = wxAppId;
    [ShareSDK connectWeChatWithAppId :_wxAppId wechatCls:[WXApi class]];
    [ShareSDK importWeChatClass:[WXApi class]];
}
- (void)connectQzoneAppKey:(NSString *)appkey appSecret:(NSString *)appSecret
{
    [ShareSDK connectQZoneWithAppKey:appkey
                           appSecret:appSecret
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
}

- (void)makeShareContent :(NSString *)content defaultConent:(NSString *)defaultContent title:(NSString *)title jumpUrl:(NSString *)jumpUrl description:(NSString *)description
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"app_logo"  ofType:@"png"];
    publishContent = [ShareSDK content:content
                        defaultContent:defaultContent
                                 image:[ShareSDK imageWithPath:imagePath]
                                 title:title
                                   url:jumpUrl
                           description:defaultContent
                             mediaType:SSPublishContentMediaTypeNews];
}
- (id<ISSShareActionSheetItem>)makeItem :(ShareType)atype :(void (^)(void))success shareFailed:(void (^)(id<ICMErrorInfo>))fail
{
    id<ISSShareActionSheetItem> wxsItem = [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:atype] icon:[ShareSDK getClientIconWithType:atype] clickHandler:^{
        
        [ShareSDK clientShareContent:publishContent type:atype statusBarTips:YES result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
            if (state == SSPublishContentStateSuccess)
            {
                if(success)
                {
                    success();
                }
            }else if (state == SSPublishContentStateFail)
            {
                if(fail)
                {
                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                    fail(error);
                }
            }
        }];
    }];
    return wxsItem;
}
- (void)addRenrenWithShareHandler:(void (^)(void))success shareFailed:(void (^)(id<ICMErrorInfo>))fail
{
    
    [shareItems addObject:[self makeItem:ShareTypeRenren :success shareFailed:fail]];
}
- (void)addQQWithShareHandler:(void (^)(void))success shareFailed:(void (^)(id<ICMErrorInfo>))fail
{
    
    [shareItems addObject:[self makeItem:ShareTypeQQ :success shareFailed:fail]];
}
- (void)addQQSpaceWithShareHandler:(void (^)(void))success shareFailed:(void (^)(id<ICMErrorInfo>))fail
{
     [shareItems addObject:[self makeItem:ShareTypeQQSpace :success shareFailed:fail]];
}
- (void)addWXChatWithShareHandler :(void (^)(void))success shareFailed:(void (^)(id<ICMErrorInfo> error))fail
{
    [shareItems addObject:[self makeItem:ShareTypeWeixiSession :success shareFailed:fail]];
}

- (NSArray*)createShareList
{
    NSMutableArray *shareList = [[NSMutableArray alloc]init];
    for (id item in shareItems)
    {
        NSArray *shareItem = [ShareSDK customShareListWithType:
                              item,
                              nil];
        [shareList addObjectsFromArray:shareItem];
        
    }
    [shareItems removeAllObjects];
    return shareList;
}
- (void)showShareItems
{
    NSArray *shareList = [self createShareList];
    [ShareSDK showShareActionSheet:nil
                         shareList:shareList
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                     NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
}

- (void)setRenrenShare:(NSString *)apiKey :(NSString *)secretKey
{
    
    
    
    //[ShareSDK connectRenRenWithAppKey:apiKey
    //                        appSecret:secretKey];
}
@end
