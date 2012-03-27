//
//  Publisher+Additions.h
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 15/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Publisher.h"

@interface Publisher (Additions)

+(Publisher*)publisherForDictionary:(NSDictionary*)dictionary;
+(Publisher*)publisherByIdentifier:(NSNumber*)identifier;

@end
