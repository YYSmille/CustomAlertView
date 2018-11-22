//
//  NSString+Attributed.m
//  ewsports
//
//  Created by ywy on 2017/4/19.
//  Copyright © 2017年 ywy. All rights reserved.
//

#import "NSString+Attributed.h"

@implementation NSString (Attributed)
- (NSMutableAttributedString *)attributedStringWithRange:(NSRange)range font:(UIFont *)font textColor:(UIColor *)textColor
{
    NSString *str = self;
    if (!str.length)
    {
        str = @"";
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
    [dict setObject:font forKey:NSFontAttributeName];
    [dict setObject:textColor forKey:NSForegroundColorAttributeName];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attributedStr setAttributes:dict range:range];
    return attributedStr;
}

- (NSMutableAttributedString *)attributedStringWithRangeStr:(NSString *)string font:(UIFont *)font textColor:(UIColor *)textColor
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self];

    NSRange range = [self rangeOfString:string];
    if (range.location == NSNotFound)
    {
        return attributedStr;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
    [dict setObject:font forKey:NSFontAttributeName];
    [dict setObject:textColor forKey:NSForegroundColorAttributeName];
    [attributedStr setAttributes:dict range:range];
    return attributedStr;
}

- (NSMutableAttributedString *)attributedStringWithRangeStringArray:(NSArray *)strs font:(UIFont *)font textColor:(UIColor *)textColor
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
    [dict setObject:font forKey:NSFontAttributeName];
    [dict setObject:textColor forKey:NSForegroundColorAttributeName];

    for (NSString *str in strs)
    {
        if ([str isKindOfClass:[NSString class]])
        {
            NSRange range = [self rangeOfString:str];
            if (range.location == NSNotFound)
            {
                continue;
            }
            [attributedStr setAttributes:dict range:range];
        }
    }
    
    return attributedStr;
}
@end
