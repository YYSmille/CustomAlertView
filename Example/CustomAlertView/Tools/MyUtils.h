//
//  MyUtils.h
//  CustomAlertView_Example
//
//  Created by ywy on 2018/11/20.
//  Copyright © 2018年 505878400@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyUtils : NSObject
+(BOOL)isValidURLString:(NSString*)urlString;

+(UIImage *)imageScale:(UIImage *)image toSize:(CGSize)size;
+(UIImage *)imageScale:(UIImage *)image maxEdge:(float)maxEdge;

+(NSString*)jsonStringFromDictionary:(NSDictionary*)dict;
+(id)jsonWithData:(NSData*)data;
+(id)jsonWithString:(NSString*)string;

+(NSString*)getAppVersion;
+(NSString*)getAppDisplayName;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+(NSString*)getCurrentDayStringWithFormat:(NSString*)format;
+(NSString *)stringFromDate:(NSDate*)date format:(NSString*)format;
+(NSDate *)dateFromString:(NSString *)dateString format:(NSString*)format;
+(NSTimeInterval)dateTimeIntervalString:(NSString *)dateString format:(NSString*)format;
@end

NS_ASSUME_NONNULL_END
