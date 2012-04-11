//
//  Book+Additions.m
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 15/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Book+Additions.h"
#import "Author+Additions.h"
#import "Publisher+Additions.h"

@implementation Book (Additions)

+(Book*)bookForDictionary:(NSDictionary*)dictionary
{
    Book* book = [Book createEntity];   //fetching
    book.name = [dictionary objectForKey:@"Name"];
    book.price = [dictionary objectForKey:@"Price"];
    book.identifier = [dictionary objectForKey:@"Identifier"];
    
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init]autorelease];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSDate *dateFromString = [dateFormat dateFromString:[dictionary objectForKey:@"ReleaseDate"]];
    book.releaseDate = dateFromString;
    
    
    NSArray *authorsArray = [dictionary objectForKey:@"Authors"];
    for (NSNumber *authorID in authorsArray) {
     
      //  NSLog(@"%@", [Author findAll]);
    Author *author = [Author authorByIdentifier:authorID];/////breakppoint
        [book addAuthorsObject:author];
    }
    
    
    NSArray *publishesArray = [dictionary objectForKey:@"Publishers"];
    for (NSNumber *publisherId in publishesArray) {
        Publisher *publisher = [Publisher publisherByIdentifier:publisherId];/////breakpoint
        [book addPublishersObject:publisher];
    }
  
    return book;
}














//might not need this if
//already using it in BookViewController
//or call this method in bookviewcontroller
+(NSArray*)booksInAlphaOrder
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name"];//fetching
    
    [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];//putting in alpha order
    
    return [Book findAllWithPredicate:predicate];
    
    
}

+(NSFetchRequest*)alphaBooks
{
    return [Book requestAllSortedBy:@"name" ascending:YES];
}

@end
