//
//  JSONSetupHelpers.m
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 15/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JSONSetupHelpers.h"
#import "Book.h"
#import "Author.h"
#import "Publisher.h"
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
        Book *book = [Book createEntity];
        book.authors = [bookDictionary objectForKey:@"Authors"];
        book.name = [bookDictionary objectForKey:@"Name"];
        book.price = [bookDictionary objectForKey:@"Price"];
        book.publishers = [bookDictionary objectForKey:@"Publishers"];
        book.releaseDate = [bookDictionary objectForKey:@"ReleaseDate"];
        book.reviews = [bookDictionary objectForKey:@"Reviews"];    }
}

+(void)authorsFirstTime
{
    NSString *authorsPath = [[NSBundle mainBundle] pathForResource:@"Authors" ofType:@"json"];
    NSData *authorsData = [NSData dataWithContentsOfFile:authorsPath];
    NSArray *authorsArray = [authorsData objectFromJSONData];
    
    for (NSDictionary *authorsDictionay in authorsArray) 
    {
        Author *author = [Author createEntity];
        author.dob = [authorsDictionay objectForKey:@"Dob"];
        author.firstName = [authorsDictionay objectForKey:@"FirstName"];
        author.surName = [authorsDictionay objectForKey:@"SurName"];
    }
}

+(void)publishersFirstTime
{
    NSString *publisherPath = [[NSBundle mainBundle] pathForResource:@"Publishers" ofType:@"json"];
    NSData *publisherData = [NSData dataWithContentsOfFile:publisherPath];
    NSArray *publisherArray = [publisherData objectFromJSONData];
    
    for (NSDictionary *publisherDictionary in publisherArray) 
    {
        Publisher *publisher = [Publisher createEntity];
        publisher.name = [publisherDictionary objectForKey:@"Name"];
    }
}

@end
