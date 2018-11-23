//
//  SVProgressHUD+extension.h
//  alert
//
//  Created by ywy on 2018/11/16.
//  Copyright © 2018年 ywy. All rights reserved.
//

#import "SVProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface SVProgressHUD (extension)

/**
 提示纯文字(默认时间0.7秒)

 @param message 内容
 */
+ (void)showMessage:(NSString *)message;

/**
 提示纯文字(默认时间0.7秒)

 @param message 内容
 @param completed 提示完成回调
 */
+ (void)showMessage:(NSString *)message completed:(SVProgressHUDDismissCompletion)completed;

/**
 提示纯文字(默认时间0.7秒)

 @param message 内容
 @param duration 显示时间
 */
+ (void)showMessage:(NSString *)message duration:(float)duration;

/**
 提示纯文字(默认时间0.7秒)

 @param message 内容
 @param duration 显示时间
 @param completed 完成回调
 */
+ (void)showMessage:(NSString *)message duration:(float)duration completed:(SVProgressHUDDismissCompletion)completed;

@end

NS_ASSUME_NONNULL_END
