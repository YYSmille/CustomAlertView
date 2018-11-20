//
//  FieldInfo.m
//  alert
//
//  Created by ywy on 2018/11/16.
//  Copyright © 2018年 ywy. All rights reserved.
//

#import "FieldInfo.h"

@implementation FieldInfo
+ (FieldInfo *)fieldInfoWithTitle:(NSString *)title selector:(SEL)selector{
    FieldInfo *info = [[FieldInfo alloc] init];
    info.title = title;
    info.selector = selector;
    return info;
}
@end
