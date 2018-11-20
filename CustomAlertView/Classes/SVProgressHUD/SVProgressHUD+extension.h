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
+ (void)showMessage:(NSString *)message;
+ (void)showMessage:(NSString *)message completed:(SVProgressHUDDismissCompletion)completed;
+ (void)showMessage:(NSString *)message duration:(float)duration;
+ (void)showMessage:(NSString *)message duration:(float)duration completed:(SVProgressHUDDismissCompletion)completed;

@end

NS_ASSUME_NONNULL_END
