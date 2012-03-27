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
        [JSONSetupHelpers importInitialauthors];
        [JSONSetupHelpers importInitialpublishers];
        [JSONSetupHelpers importInitialbooks];
    }
    [SettingsManager setFirstTimeComplete];
    
    return isFirstTime;
}

+(void)importInitialbooks
{
    NSString *booksPath = [[NSBundle mainBundle] pathForResource:@"Books" ofType:@"json"];
    NSData *booksData = [NSData dataWithContentsOfFile:booksPath];
    NSArray *booksArray = [booksData objectFromJSONData];
    
    for (NSDictionary *bookDictionary in booksArray) 
    {
        [Book bookForDictionary:bookDictionary];        
    }
    [[NSManagedObjectContext contextForCurrentThread] save];
}

+(void)importInitialauthors
{
    NSLog(@"%@", [Author findAll]);

    NSString *authorsPath = [[NSBundle mainBundle] pathForResource:@"Author" ofType:@"json"];
    NSData *authorsData = [NSData dataWithContentsOfFile:authorsPath];
    NSArray *authorsArray = [authorsData objectFromJSONData];
    
    for (NSDictionary *authorsDictionay in authorsArray) //for every object in authos array it expects it to be nsdictionary
    {
        if ([authorsDictionay isKindOfClass:[NSDictionary class]]) { //if the object is a dictionary perform this check
                [Author authorForDictionary:authorsDictionay];
        }
        
    }
    [[NSManagedObjectContext contextForCurrentThread] save];
}

+(void)importInitialpublishers
{
    NSString *publisherPath = [[NSBundle mainBundle] pathForResource:@"Publishers" ofType:@"json"];
    NSData *publisherData = [NSData dataWithContentsOfFile:publisherPath];
    NSArray *publisherArray = [publisherData objectFromJSONData];
    
    for (NSDictionary *publisherDictionary in publisherArray) 
    {
        [Publisher publisherForDictionary:publisherDictionary];
    }
    [[NSManagedObjectContext contextForCurrentThread] save];

}

@end
