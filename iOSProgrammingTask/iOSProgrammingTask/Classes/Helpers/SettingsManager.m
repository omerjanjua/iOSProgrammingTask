//
//  SettingsManager.m
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 15/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsManager.h"

@implementation SettingsManager

#define FIRSTSTARTKEY @"FIRSTSTART"

+(void)setFirstTimeComplete
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey: FIRSTSTARTKEY];
}

+(BOOL)isFirstTime
{
    NSNumber *firstStartNumber = [[NSUserDefaults standardUserDefaults] objectForKey: FIRSTSTARTKEY];
    BOOL isFirstStart = ![firstStartNumber boolValue];
    return isFirstStart;
}

@end
