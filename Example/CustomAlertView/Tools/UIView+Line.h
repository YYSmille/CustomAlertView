//
//  UIView+Line.h
//  DongADong
//
//  Created by YuWeiYang on 15-5-16.
//  Copyright (c) 2015年 LiZhiliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Line)
- (void)setUpTopLine;
- (void)setUpTopLineWithLineColor:(UIColor *)lineColor;

- (void)setUpBottomLine;
- (void)setUpBottomLineWithLineColor:(UIColor *)lineColor;
/**设置水平线*/
- (void)setUpHorizontalLine:(CGFloat)y;
- (void)setUpHorizontalLine:(CGFloat)y lineColor:(UIColor *)lineColor lineHeight:(CGFloat)lineHeight;
- (void)setUpHeaderLineWithLineColor:(UIColor *)lineColor;
- (void)setUpHeaderLine;
- (void)setUpRightLine;
@end
