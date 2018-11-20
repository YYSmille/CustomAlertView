//
//  CustomAlertView.m
//  alert
//
//  Created by ywy on 2018/11/16.
//  Copyright © 2018年 ywy. All rights reserved.
//

#import "CustomAlertView.h"
static CGFloat leftMargin = 25;
static CGFloat alertW = 280;

@interface CustomAlertView () <UITextViewDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *placeholderLabel;



@property (nonatomic, strong) UIView *alertView;

@property (nonatomic, strong) NSMutableArray <UIButton *>*btnList;

@end

@implementation CustomAlertView
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate btnTitles:(NSArray<NSString *> *)btnTitles{
    if (self = [super init]) {
        [self initConfig];
        self.frame = [UIScreen mainScreen].bounds;
        self.delegate = delegate;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [self addSubview:self.alertView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.alertView addSubview:_titleLabel];
        _titleLabel.font = [UIFont systemFontOfSize:self.titleFontSize];
        _titleLabel.textColor = self.titleColor;
        _titleLabel.text = title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        _contentLabel = [[UILabel alloc] init];
        [self.alertView addSubview:_contentLabel];
        _contentLabel.font = [UIFont systemFontOfSize:self.messageFontSize];
        _contentLabel.textColor = self.messageColor;
        _contentLabel.text = message;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.numberOfLines = 0;
        
        [self creatBottomBtnsView:btnTitles];
        
        [self updateAlertFrame];

    }
    return self;
    
}


- (instancetype)initWithTextViewTitle:(NSString *)title message:(NSString *)message placeholder:(NSString *)placeholder maxEditNum:(NSInteger)maxEditNum delegate:(id)delegate btnTitles:(NSArray<NSString *> *)btnTitles{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [self initConfig];
        _maxNum = maxEditNum;
        self.frame = [UIScreen mainScreen].bounds;
        self.delegate = delegate;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [self addSubview:self.alertView];
        CGFloat w = alertW - 2 * leftMargin;

        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.alertView addSubview:_titleLabel];
        _titleLabel.font = [UIFont systemFontOfSize:self.titleFontSize];
        _titleLabel.textColor = self.titleColor;
        _titleLabel.text = title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        UIView *textBgView = [[UIView alloc] init];
        [self.alertView addSubview:textBgView];
        textBgView.bounds = CGRectMake(0, 0, w, 60);
        textBgView.backgroundColor = [CustomAlertView colorWithColorStr:@"#f6f6f6"];

        
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.delegate = self;
        [textBgView addSubview:_textView];
        _textView.font = [UIFont systemFontOfSize:self.messageFontSize];
        _textView.text = message;
        _textView.frame = CGRectMake(6, 2, w - 2 * 6, 58);
//        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.textAlignment = NSTextAlignmentLeft | NSTextAlignmentLeft;
        _placeholderLabel.numberOfLines = 0;
        [textBgView addSubview:_placeholderLabel];
        _placeholderLabel.font = _textView.font;
        _placeholderLabel.textColor = _placeholderColor;
        _placeholderLabel.text = placeholder;
        _placeholderLabel.frame = CGRectMake(8, 8, w - 2 * 8, 52);
        _placeholderLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        
        if (message.length > 0) {
            _placeholderLabel.hidden = YES;
        }

        [self creatBottomBtnsView:btnTitles];
        [self updateAlertFrame];
    }
    return self;
}

- (void)creatBottomBtnsView:(NSArray<NSString *> *)btnTitles{
    CGFloat btnW = alertW - 2 * leftMargin;
    CGFloat btnH = 40;
    UIView *btnBgView = [[UIView alloc] init];
    btnBgView.backgroundColor = [UIColor yellowColor];
    [self.alertView addSubview:btnBgView];
    btnBgView.frame = CGRectMake(0, -btnH, alertW, btnH);
    btnBgView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    if (btnTitles.count > 0) {
        btnW = alertW / btnTitles.count;
    }
    
    UIFont *btnFont = [UIFont systemFontOfSize:self.btnFontSize];
    for (NSInteger i = 0; i < btnTitles.count; i ++) {
        NSString *btnStr = btnTitles[i];
        NSArray *array = [btnStr componentsSeparatedByString:@"_"];
        NSString *title = @"";
        UIColor *textColor = [CustomAlertView colorWithColorStr:@"#2774FF"];
        UIColor *backgroundColor = [CustomAlertView colorWithColorStr:@"#ffffff"];
        
        if (array.count == 3) {
            title = array[0];
            textColor = [CustomAlertView colorWithColorStr:array[1]];
            backgroundColor = [CustomAlertView colorWithColorStr:array[2]];
            
        }
        else if (array.count == 2){
            title = array[0];
            textColor = [CustomAlertView colorWithColorStr:array[1]];
        }
        else{
            title = btnStr;
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnW * i, 0, btnW, btnH);
        [btnBgView addSubview:btn];
        btn.tag = i;
        btn.titleLabel.font = btnFont;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setBackgroundColor:backgroundColor];
        [btn setTitleColor:textColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnIndexClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnList addObject:btn];
    }
}


- (void)updateAlertFrame{
    CGFloat y = 20;
    CGFloat w = alertW - 2 * leftMargin;
    CGSize sz = [_titleLabel sizeThatFits:CGSizeMake(w, MAXFLOAT)];
    _titleLabel.frame = CGRectMake(leftMargin, y, w, sz.height);
    
    y += sz.height + 15;
    if (_contentLabel != nil) {
        sz = [_contentLabel sizeThatFits:CGSizeMake(w, MAXFLOAT)];
        _contentLabel.frame = CGRectMake(leftMargin, y, w, sz.height);
    }
    else if(_textView != nil){
        sz = CGSizeMake(w, 60);
        _textView.superview.frame = CGRectMake(leftMargin, y, w, sz.height);
    }

    
    y += sz.height + 20;
    
    //        CGFloat x = ([UIScreen mainScreen].bounds.size.width - alertW) * 0.5;
    
    CGFloat h = y + 40;
    self.alertView.bounds = CGRectMake(0, 0, alertW, h);
    self.alertView.center = self.center;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (_placeholderLabel != nil) {
        [_placeholderLabel sizeToFit];
    }
}

#pragma mark - event
- (void)btnIndexClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(customAlertView:clickedButtonAtIndex:)]) {
        [self.delegate customAlertView:self clickedButtonAtIndex:btn.tag];
    }
    [self dismiss];
}

- (void)show{
    [UIView animateWithDuration:0.7 animations:^{
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }];
}


- (void)dismiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(customAlertViewDidHide:)]) {
            [self.delegate customAlertViewDidHide:self];
        }
        [self removeFromSuperview];
    }];
}


#pragma mark - textview
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 0) {
        _placeholderLabel.hidden = YES;
    }
    else{
        _placeholderLabel.hidden = NO;
    }
    
    if (self.maxNum > 0) {
        if (textView.text.length > self.maxNum){
            textView.text = [textView.text substringToIndex:self.maxNum];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(customAlertView:textDidChanged:)]) {
        [self.delegate customAlertView:self textDidChanged:textView.text];
    }

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    NSString *toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if (self.maxNum > 0) {
        if (toBeString.length > self.maxNum) {
            return NO;
        }
    }
    return YES;
}

#pragma mark - notification
- (void)keyBoardWillChangeFrame:(NSNotification *)notification{
    NSDictionary *dict = notification.userInfo;
    CGRect kbRect = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.alertView.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    if (kbRect.origin.y < CGRectGetMaxY(self.alertView.frame)) {
        [UIView animateWithDuration:duration animations:^{
            self.alertView.frame = CGRectMake(self.alertView.frame.origin.x, kbRect.origin.y - self.alertView.frame.size.height, self.alertView.frame.size.width, self.alertView.frame.size.height);
        }];
        
    }


}

- (void)initConfig{
    _btnList = [NSMutableArray array];

    _type = ABCustomAlertTypeText;
    _titleFontSize = 15;
    _titleColor = [CustomAlertView colorWithColorStr:@"#343434"];
    
    _messageFontSize = 16;
    _messageColor = [CustomAlertView colorWithColorStr:@"#737373"];
    
    _placeholderColor = [CustomAlertView colorWithColorStr:@"#c8c8c8"];
    
    _btnFontSize = 16;
    
    _maxNum = 300;
}

#pragma mark - getter-setter
- (UIView *)alertView{
    if (_alertView == nil) {
        _alertView = [[UIView alloc] init];
        _alertView.layer.cornerRadius = 5;
        _alertView.backgroundColor = [UIColor whiteColor];
    }
    return _alertView;
}

- (void)setBtnFontSize:(CGFloat)btnFontSize{
    _btnFontSize = btnFontSize;
    UIFont *font = [UIFont systemFontOfSize:btnFontSize];
    for (UIButton *btn in self.btnList) {
        btn.titleLabel.font = font;
    }
}

- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    _titleLabel.textColor = titleColor;
}

- (void)setTitleFontSize:(CGFloat)titleFontSize{
    _titleFontSize = titleFontSize;
    _titleLabel.font = [UIFont systemFontOfSize:titleFontSize];
    [self updateAlertFrame];
}

- (void)setMessageColor:(UIColor *)messageColor{
    _messageColor = messageColor;
    if (_contentLabel != nil) {
        _contentLabel.textColor = messageColor;
    }
    
    if (_textView != nil) {
        _textView.textColor = messageColor;
    }
}

- (void)setMessageFontSize:(CGFloat)messageFontSize{
    _messageFontSize = messageFontSize;
    if (_contentLabel != nil) {
        _contentLabel.font = [UIFont systemFontOfSize:messageFontSize];
        [self updateAlertFrame];
    }
    
    if (_textView != nil) {
        _textView.font = [UIFont systemFontOfSize:messageFontSize];
        if (_placeholderLabel != nil) {
            _textView.font = [UIFont systemFontOfSize:messageFontSize];
        }

    }
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    if (_placeholderLabel != nil) {
        _placeholderLabel.textColor = placeholderColor;
    }
}

+ (UIColor*)colorWithColorStr:(NSString *)colorStr {
    // 判断长度先
    if (colorStr.length < 6) return nil;
    // 去掉空格等其他字符
    NSString *cString = [[colorStr stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    
    if ([cString length] < 6 || [cString length] > 8) return nil;
    
    static int COLOR_LENGTH = 4;
    // Alpha Red Green Blue
    unsigned int colorARGB[COLOR_LENGTH];
    for (int i = 0; i < 4; i++) {
        // 先初始化为所有都是255
        colorARGB[COLOR_LENGTH-i-1] = 255;
        
        // 根据子字符串进行数字转换
        NSString *subString = [cString substringFromIndex: cString.length < 2 ? 0 : cString.length - 2];
        cString = [cString substringToIndex:cString.length < 2 ? cString.length : cString.length - 2];
        if (subString.length) {
            [[NSScanner scannerWithString:subString] scanHexInt:&colorARGB[COLOR_LENGTH-i-1]];
        }
    }
    
    return [UIColor colorWithRed:((float) colorARGB[1] / 255.0f)
                           green:((float) colorARGB[2] / 255.0f)
                            blue:((float) colorARGB[3] / 255.0f)
                           alpha:((float) colorARGB[0] / 255.0f)];
}


@end
