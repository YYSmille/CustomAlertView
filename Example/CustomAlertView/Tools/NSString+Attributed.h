//
//  NSString+Attributed.h
//  ewsports
//
//  Created by ywy on 2017/4/19.
//  Copyright © 2017年 ywy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Attributed)
- (NSMutableAttributedString *)attributedStringWithRange:(NSRange)range font:(UIFont *)font textColor:(UIColor *)textColor;
- (NSMutableAttributedString *)attributedStringWithRangeStr:(NSString *)string font:(UIFont *)font textColor:(UIColor *)textColor;
- (NSMutableAttributedString *)attributedStringWithRangeStringArray:(NSArray *)strs font:(UIFont *)font textColor:(UIColor *)textColor;

@end
