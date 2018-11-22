//
//  MyUtils.m
//  CustomAlertView_Example
//
//  Created by ywy on 2018/11/20.
//  Copyright © 2018年 505878400@qq.com. All rights reserved.
//

#import "MyUtils.h"

@implementation MyUtils
+(BOOL)isValidURLString:(NSString*)urlString
{
    
    if( urlString && [urlString length] > 7 )
    {
        char* p = (char*)[urlString UTF8String];
        if( strncasecmp(p, "http://", 7 ) == 0 || strncasecmp(p, "https://", 8) == 0 )
            return YES;
    }
    
    return NO;
}


+(UIImage *)imageScale:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext ();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+ (UIImage *)imageScale:(UIImage *)image maxEdge:(float)maxEdge
{
    float w = image.size.width;
    float h = image.size.height;
    
    float w1 = w;
    float h1 = h;
    if( w >= h )
    {
        if( w1 > maxEdge )
            w1 = maxEdge;
        
        h1 = w1 * h / w;
    }
    else{
        if( h1 > maxEdge )
            h1 = maxEdge;
        
        w1 = w * h1 / h;
    }
    
    
    UIGraphicsBeginImageContext(CGSizeMake(w1, h1));
    
    [image drawInRect:CGRectMake(0, 0, w1, h1)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext ();
    UIGraphicsEndImageContext();
    return scaledImage;
}


+(NSString*)jsonStringFromDictionary:(NSDictionary*)dict
{
    NSData* data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


+(id)jsonWithData:(NSData*)data
{
    NSError* error = nil;
    id a = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if( error )
        NSLog(@"%@", error);
    return a;
}


+(id)jsonWithString:(NSString*)string
{
    NSError* error = nil;
    return [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding]
                                           options:NSJSONReadingAllowFragments error:&error];
}

+(NSString*)getAppVersion
{
    return [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];//(NSString*)kCFBundleVersionKey]];
}

+ (NSString *)getAppDisplayName
{
    return [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]];
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

+(NSString*)getCurrentDayStringWithFormat:(NSString*)format
{
    NSDate* de = [NSDate date];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    if( format )
        dateFormatter.dateFormat = format;
    else
        dateFormatter.dateFormat = @"yyyy-MM-dd"; // yyyy-MM-dd HH:mm:ss
    NSString* ss = [dateFormatter stringFromDate:de];
    //    [dateFormatter release];
    
    return ss;
}

+(NSString *)stringFromDate:(NSDate*)date format:(NSString*)format{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if( format )
        [dateFormatter setDateFormat: format];
    else
        [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    
    return [dateFormatter stringFromDate:date];
    
}

+(NSDate *)dateFromString:(NSString *)dateString format:(NSString*)format{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if( format )
        [dateFormatter setDateFormat: format];
    else
        [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    //    [dateFormatter release];
    
    return destDate;
    
}

+ (NSTimeInterval)dateTimeIntervalString:(NSString *)dateString format:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if( format )
        [dateFormatter setDateFormat: format];
    else
        [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate = [dateFormatter dateFromString:dateString];
    if (destDate != nil) {
        return [destDate timeIntervalSince1970];
    }
    return 0;
}
@end
