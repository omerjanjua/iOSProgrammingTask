//
//  NSDate+Additions.m
//  Rebif
//
//  Created by CL-iMac-27 on 21/07/2011.
//  Copyright 2011 Creative Lynx All rights reserved.
//

#import "NSDate+Additions.h"


@implementation NSDate (Additions)

+ (NSDate *)dateFromStringWithFormat:(NSString*)string format:(NSString*)format
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:format];
    NSDate *dateFromString = [df dateFromString:string];
    return dateFromString;
}

+ (NSString *)stringFromDateWithFormat:(NSDate*)date format:(NSString*)format
{
    NSDateFormatter *currentDateFormat = [[NSDateFormatter alloc]init];
    [currentDateFormat setDateFormat:format];    
    
    NSString *stringFromDate = [currentDateFormat stringFromDate:date];
    
	return stringFromDate;
}

@end
