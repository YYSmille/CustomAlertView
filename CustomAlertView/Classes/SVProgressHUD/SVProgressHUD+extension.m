//
//  SVProgressHUD+extension.m
//  alert
//
//  Created by ywy on 2018/11/16.
//  Copyright © 2018年 ywy. All rights reserved.
//

#import "SVProgressHUD+extension.h"
static float duratiomTime = 0.7f;
@implementation SVProgressHUD (extension)
+ (void)load{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setImageViewSize:CGSizeZero];
//    [SVProgressHUD setInfoImage:[[UIImage alloc] init]];
//    [SVProgressHUD setInfoImage:nil];
//    [SVProgressHUD setSuccessImage:nil];
    [SVProgressHUD setErrorImage:[[UIImage alloc] init]];
    [SVProgressHUD setShouldTintImages:NO];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setMinimumDismissTimeInterval:MAXFLOAT];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];

}

+ (void)showMessage:(NSString *)message{
//    [SVProgressHUD showWithStatus:message];
//    [SVProgressHUD showSuccessWithStatus:message];
    [self showMessage:message duration:duratiomTime completed:nil];
}

+ (void)showMessage:(NSString *)message completed:(SVProgressHUDDismissCompletion)completed{
    [self showMessage:message duration:duratiomTime completed:completed];
}

+ (void)showMessage:(NSString *)message duration:(float)duration{
    [self showMessage:message duration:duration completed:nil];
}

+ (void)showMessage:(NSString *)message duration:(float)duration completed:(void (^)(void))completed{
    [SVProgressHUD dismiss];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideProgressHUD) object:nil];
    if (message.length) {
        [SVProgressHUD showInfoWithStatus:message];
    }
    else{
        [SVProgressHUD show];
    }
//    [SVProgressHUD dismissWithDelay:duration];
//    NSLog(@"thread----%@", [NSThread currentThread]);
    [self performSelector:@selector(hideProgressHUD) withObject:nil afterDelay:duration];
}

+ (void)hideProgressHUD{
    [SVProgressHUD dismiss];
};
@end
