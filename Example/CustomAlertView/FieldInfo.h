//
//  FieldInfo.h
//  alert
//
//  Created by ywy on 2018/11/16.
//  Copyright © 2018年 ywy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FieldInfo : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) SEL selector;

+ (FieldInfo *)fieldInfoWithTitle:(NSString *)title selector:(SEL)selector;
@end

NS_ASSUME_NONNULL_END
