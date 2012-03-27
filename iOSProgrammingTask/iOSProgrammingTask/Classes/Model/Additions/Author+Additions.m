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
    author.firstName = [dictionary objectForKey:@"FirstName"];
    author.surname = [dictionary objectForKey:@"Surname"];
    author.identifier = [dictionary objectForKey:@"Identifier"];
    
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc]init]autorelease];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSDate *dateFromString = [dateFormat dateFromString:[dictionary objectForKey:@"Dob"]];
    author.dob = dateFromString;
    
        
    return author;
}

+(Author*)authorByIdentifier:(NSNumber*)identifer
{
//    NSNumber *number = [NSNumber numberWithInt:identifer];
    return [Author findFirstByAttribute:@"identifier" withValue:identifer];
}

+(Author*)authorFirstName:(NSString*)firstName
{
    return [Author findFirstByAttribute:@"firstName" withValue:firstName];
}

+(Author*)authorsurname:(NSString*)surname
{
    return [Author findFirstByAttribute:@"surname" withValue:surname];
}

@end
