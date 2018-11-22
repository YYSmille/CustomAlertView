//
//  UIView+Line.m
//  DongADong
//
//  Created by YuWeiYang on 15-5-16.
//  Copyright (c) 2015年 LiZhiliang. All rights reserved.
//

#import "UIView+Line.h"
#define RGBCOLOR(r,g,b)     [UIColor colorWithRed:(float)r/255 green:(float)g/255 blue:(float)b/255 alpha:1]
#define shadowLineColor         RGBCOLOR(225,225,225)

@implementation UIView (Line)
- (void)setUpTopLine
{
    [self setUpTopLineWithLineColor:shadowLineColor];
}

- (void)setUpTopLineWithLineColor:(UIColor *)lineColor
{
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = lineColor;
    line.frame = CGRectMake(0, 0, self.frame.size.width, 0.5);
    line.autoresizingMask = UIViewAutoresizingFlexibleWidth| UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:line];

}

- (void)setUpBottomLine
{
    [self setUpBottomLineWithLineColor:shadowLineColor];
}

- (void)setUpBottomLineWithLineColor:(UIColor *)lineColor{
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = lineColor;
    line.frame = CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5);
    line.autoresizingMask = UIViewAutoresizingFlexibleWidth| UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:line];

}

- (void)setUpHorizontalLine:(CGFloat)y
{
    [self setUpHorizontalLine:y lineColor:shadowLineColor lineHeight:0.5f];
}

- (void)setUpHorizontalLine:(CGFloat)y lineColor:(UIColor *)lineColor lineHeight:(CGFloat)lineHeight
{
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = lineColor;
    line.frame = CGRectMake(0, y, self.frame.size.width, lineHeight);
    line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:line];
}

- (void)setUpHeaderLineWithLineColor:(UIColor *)lineColor
{
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = lineColor;
    line.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5);
    [self addSubview:line];

}

- (void)setUpHeaderLine {
    [self setUpHeaderLineWithLineColor:shadowLineColor];
}

- (void)setUpRightLine
{
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = shadowLineColor;
    line.frame = CGRectMake(self.frame.size.width - 0.5f, 0, 0.5f, self.frame.size.height);
    line.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleLeftMargin;
    [self addSubview:line];

}
@end
