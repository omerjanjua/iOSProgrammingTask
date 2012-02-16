//
//  Author+Additions.h
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 15/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Author.h"

@interface Author (Additions)

+(Author*)authorForDictionary:(NSDictionary*)dictionary;

@end
