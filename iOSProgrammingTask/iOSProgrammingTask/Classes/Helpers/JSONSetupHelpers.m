//
//  JSONSetupHelpers.m
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 15/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JSONSetupHelpers.h"
#import "Additions.h"
#import "SettingsManager.h"

@implementation JSONSetupHelpers

+(BOOL)performFirstTimeSetup
{
    BOOL isFirstTime = [SettingsManager isFirstTime];
    
    if (isFirstTime) 
    {
        [JSONSetupHelpers booksFirstTime];
        [JSONSetupHelpers authorsFirstTime];
        [JSONSetupHelpers publishersFirstTime];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
    [SettingsManager setFirstTimeComplete];
    
    [[NSManagedObjectContext defaultContext] save];
    
    return isFirstTime;
}

+(void)booksFirstTime
{
    NSString *booksPath = [[NSBundle mainBundle] pathForResource:@"Books" ofType:@"json"];
    NSData *booksData = [NSData dataWithContentsOfFile:booksPath];
    NSArray *booksArray = [booksData objectFromJSONData];
    
    for (NSDictionary *bookDictionary in booksArray) 
    {
        [Book bookForDictionary:bookDictionary];        
    }
}

+(void)authorsFirstTime
{
    NSString *authorsPath = [[NSBundle mainBundle] pathForResource:@"Authors" ofType:@"json"];
    NSData *authorsData = [NSData dataWithContentsOfFile:authorsPath];
    NSArray *authorsArray = [authorsData objectFromJSONData];
    
    for (NSDictionary *authorsDictionay in authorsArray) 
    {
        [Author authorForDictionary:authorsDictionay];
    }
}

+(void)publishersFirstTime
{
    NSString *publisherPath = [[NSBundle mainBundle] pathForResource:@"Publishers" ofType:@"json"];
    NSData *publisherData = [NSData dataWithContentsOfFile:publisherPath];
    NSArray *publisherArray = [publisherData objectFromJSONData];
    
    for (NSDictionary *publisherDictionary in publisherArray) 
    {
        [Publisher publisherForDictionary:publisherDictionary];
    }
}

@end
