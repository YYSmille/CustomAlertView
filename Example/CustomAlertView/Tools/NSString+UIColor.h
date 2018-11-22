//
//  NSString+UIColor.h
//  DongADong
//
//  Created by 李恒—henryLi on 13/5/16.
//  Copyright (c) 2013年 LiZhiliang. All rights reserved.
//

#import <Foundation/Foundation.h>

// 用于扩展NSString,转换UIColor
@interface NSString (UIColor)

// 获取由当前的NSString转换来的UIColor
- (UIColor*)color;

@end
