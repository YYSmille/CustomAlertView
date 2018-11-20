//
//  CustomAlertView.h
//  alert
//
//  Created by ywy on 2018/11/16.
//  Copyright © 2018年 ywy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, ABCustomAlertType) {
    ABCustomAlertTypeText = 0,
    ABCustomAlertTypeEdit,
};

@class CustomAlertView;
@protocol CustomAlertViewDelegate <NSObject>
@optional
- (void)customAlertView:(CustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)customAlertView:(CustomAlertView *)alertView textDidChanged:(NSString *)text;
- (void)customAlertViewDidHide:(CustomAlertView *)alertView;
@end

@interface CustomAlertView : UIView
@property (nonatomic, weak) id <CustomAlertViewDelegate> delegate;
@property (nonatomic, assign, readonly) ABCustomAlertType type;

@property (nonatomic, assign) CGFloat titleFontSize;
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, assign) CGFloat messageFontSize;
@property (nonatomic, strong) UIColor *messageColor;

//@property (nonatomic, assign) CGFloat placeholderFontSize;
@property (nonatomic, strong) UIColor *placeholderColor;


@property (nonatomic, assign) CGFloat btnFontSize;

// 可编辑最大字数 默认300
@property (nonatomic, assign) NSInteger maxNum;



// btnTitles格式 text_#2774FF(文字颜色)_#2774FF(背景颜色) 
- (instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id /**<CustomAlertViewDelegate>*/)delegate btnTitles:(NSArray<NSString *> *)btnTitles;
- (instancetype)initWithTextViewTitle:(NSString *)title message:(NSString *)message placeholder:(NSString *)placeholder maxEditNum:(NSInteger)maxEditNum delegate:(id)delegate btnTitles:(NSArray<NSString *> *)btnTitles;
- (void)show;
@end

NS_ASSUME_NONNULL_END
