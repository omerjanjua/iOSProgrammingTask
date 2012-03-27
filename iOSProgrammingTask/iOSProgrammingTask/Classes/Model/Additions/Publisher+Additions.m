//
//  Publisher+Additions.m
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 15/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Publisher+Additions.h"

@implementation Publisher (Additions)

+(Publisher*)publisherForDictionary:(NSDictionary*)dictionary
{
    Publisher* publisher = [Publisher createEntity];
    
    publisher.name = [dictionary objectForKey:@"Name"];
    publisher.identifier = [dictionary objectForKey:@"Identifier"];
    
    return publisher;
}

+(Publisher*)publisherByIdentifier:(NSNumber*)identifier
{
    return [Publisher findFirstByAttribute:@"identifier" withValue:identifier];
}

@end
