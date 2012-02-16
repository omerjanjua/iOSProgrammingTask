//
//  Author+Additions.m
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 15/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Author+Additions.h"

@implementation Author (Additions)

+(Author*)authorForDictionary:(NSDictionary*)dictionary
{
    Author* author = [Author createEntity];
    author.dob = [dictionary objectForKey:@"Dob"];
    author.firstName = [dictionary objectForKey:@"FirstName"];
    author.surName = [dictionary objectForKey:@"SurName"];
    
    return author;
}

@end
