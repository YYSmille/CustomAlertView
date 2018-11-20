//
//  CustomTipView.h
//  CustomAlertView
//
//  Created by ywy on 2018/11/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTipView : UIView
@property (nonatomic, strong,readonly) UILabel *tipLabel;
@property (nonatomic, strong,readonly) UIView *tipBgView;
+ (void)showTipWithTitle:(NSString *)title duration:(NSTimeInterval)duration complete:(void(^)())complete;
- (void)showWithDuration:(NSTimeInterval)duration complete:(void (^)())complete;
@end

NS_ASSUME_NONNULL_END
