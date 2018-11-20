//
//  CustomTipView.m
//  CustomAlertView
//
//  Created by ywy on 2018/11/20.
//
#define iPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !iPad : NO)
#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !iPad : NO)
#define iPhoneXSMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !iPad : NO)

#define iPhoneFull iPhoneX || iPhoneXR || iPhoneXSMax
#define kNavigationStatusBarHei 20 + (iPhoneFull ? 24.0 : 0)

#import "CustomTipView.h"
@implementation CustomTipView
//{
//    UILabel *_tipLabel;
//}
+ (void)showTipWithTitle:(NSString *)title duration:(NSTimeInterval)duration complete:(void (^)())complete{
    CustomTipView *tipView = [[CustomTipView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    tipView.tipLabel.text = title;
    [tipView showWithDuration:duration complete:complete];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _tipBgView = [[UIView alloc] init];
        _tipBgView.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kNavigationStatusBarHei + 44);
        _tipBgView.backgroundColor = [UIColor redColor];
        [self addSubview:_tipBgView];
        _tipLabel = [[UILabel alloc] init];
        [_tipBgView addSubview:_tipLabel];
        _tipLabel.numberOfLines = 0;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.font = [UIFont systemFontOfSize:15];
        _tipLabel.textColor = [UIColor colorWithRed:33 green:33 blue:33 alpha:1];
        _tipLabel.frame = CGRectMake(15, kNavigationStatusBarHei, _tipBgView.bounds.size.width - 30, _tipBgView.bounds.size.height - kNavigationStatusBarHei);
//        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_tipBgView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_tipLabel attribute:NSLayoutAttributeLeft multiplier:1 constant:15];
//        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:_tipBgView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_tipLabel attribute:NSLayoutAttributeRight multiplier:1 constant:-15];
//        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_tipBgView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_tipLabel  attribute:NSLayoutAttributeTop multiplier:1 constant:0];
//        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_tipBgView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_tipLabel  attribute:NSLayoutAttributeBottom multiplier:1 constant:kNavigationStatusBarHei];
//        [_tipLabel addConstraints:@[leftConstraint, rightConstraint, topConstraint, bottomConstraint]];

        
    }
    return self;
}

- (void)showWithDuration:(NSTimeInterval)duration complete:(void (^)())complete{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    __block CGRect rc = _tipBgView.frame;
    rc.origin.x = 0;
    rc.origin.y = - rc.size.height;
    _tipBgView.frame = rc;
    [UIView animateWithDuration:duration animations:^{
        rc.origin.y = 0;
        _tipBgView.frame = rc;
    } completion:^(BOOL finished) {
        if (complete != nil) {
            complete();
        }
        [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
