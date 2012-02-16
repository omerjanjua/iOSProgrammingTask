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
    Book* book = [Book createEntity];
    
    book.authors = [dictionary objectForKey:@"Authors"];
    book.name = [dictionary objectForKey:@"Name"];
    book.price = [dictionary objectForKey:@"Price"];
    book.publishers = [dictionary objectForKey:@"Publishers"];
    book.releaseDate = [dictionary objectForKey:@"ReleaseDate"];
    book.reviews = [dictionary objectForKey:@"Reviews"];
    
    return book;
}

@end
