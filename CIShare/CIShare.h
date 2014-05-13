//
//  CIShare.h
//  CIShareDemo
//
//  Created by zhao on 14-5-12.
//  Copyright (c) 2014年 zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>

@interface CIShare : NSObject
{
    @private
    NSMutableArray *shareItems;
    id<ISSContent> publishContent;
}

@property (nonatomic,copy) NSString *wxAppId;
@property (nonatomic,copy) NSString *qqAppId;

- (void)connectQzoneAppKey :(NSString*)appkey appSecret:(NSString*)appSecret;


+ (instancetype)sharedInstance;

/**
 *  @brief 到shareSDK 注册appId
 */
- (void)registerApp :(NSString*)appId;
/**
 *	@brief	设置微信的分享，调用此函数之前应该先设置wxAppId。
 *	@param 	sharesSuccess 分享成功时的回调
 *  @param  fail  分享失败时的回调
 
 */
- (void)addWXChatWithShareHandler :(void (^)(void))success shareFailed:(void (^)(id<ICMErrorInfo> error))fail;

/**
 *	@brief	设置人人的分享，调用此函数之前应该先调用 setRenrenShare。
 *	@param 	sharesSuccess 分享成功时的回调
 *  @param  fail  分享失败时的回调
 
 */
- (void)addRenrenWithShareHandler :(void (^)(void))success shareFailed:(void (^)(id<ICMErrorInfo> error))fail;

/**
 *	@brief	设置QQ的分享，调用此函数之前应该先调用 setRenrenShare。
 *	@param 	sharesSuccess 分享成功时的回调
 *  @param  fail  分享失败时的回调
 
 */
- (void)addQQWithShareHandler:(void (^)(void))success shareFailed:(void (^)(id<ICMErrorInfo>))fail;
/**
 *	@brief	设置QQ空间的分享，调用此函数之前应该先调用 setRenrenShare。
 *	@param 	sharesSuccess 分享成功时的回调
 *  @param  fail  分享失败时的回调
 
 */


- (void)addQQSpaceWithShareHandler:(void (^)(void))success shareFailed:(void (^)(id<ICMErrorInfo>))fail;
/**
 * @brief 构造分享内容
 * @param content  分享的内容
 * @param defaultContent 当content为空的时候展示的内容
 * @param title 分享的标题
 * @param jumpUrl 跳转地址
 * @param description 描述
 */
- (void)makeShareContent :(NSString *)content defaultConent:(NSString *)defaultContent title:(NSString *)title jumpUrl:(NSString *)jumpUrl description:(NSString *)description;

- (void)setRenrenShare :(NSString *)apiKey :(NSString*)secretKey;
- (void)showShareItems;
@end
