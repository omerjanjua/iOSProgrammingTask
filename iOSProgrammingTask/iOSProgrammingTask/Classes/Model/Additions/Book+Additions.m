//
//  Book+Additions.m
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 15/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Book+Additions.h"

@implementation Book (Additions)

+(Book*)bookForDictionary:(NSDictionary*)dictionary
{
    Book* book = [Book createEntity];   //fetching
    
    book.authors = [dictionary objectForKey:@"Authors"];
    book.name = [dictionary objectForKey:@"Name"];
    book.price = [dictionary objectForKey:@"Price"];
    book.publishers = [dictionary objectForKey:@"Publishers"];
    book.reviews = [dictionary objectForKey:@"Reviews"];
    
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init]autorelease];
    [dateFormat setDateFormat:@"dd-MMMM-yyyy"];
    NSDate *dateFromString = [dateFormat dateFromString:[dictionary objectForKey:@"ReleaseDate"]];
    book.releaseDate = dateFromString;
  
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
