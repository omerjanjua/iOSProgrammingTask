//
//  NSDate+Additions.h
//  Rebif
//
//  Created by CL-iMac-27 on 21/07/2011.
//  Copyright 2011 Creative Lynx All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (Additions)

+ (NSDate *)dateFromStringWithFormat:(NSString*)string format:(NSString*)format;
+ (NSString *)stringFromDateWithFormat:(NSDate*)date format:(NSString*)format;

@end
