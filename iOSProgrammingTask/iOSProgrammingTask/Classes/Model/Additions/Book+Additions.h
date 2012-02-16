//
//  Book+Additions.h
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 15/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"

@interface Book (Additions)

+(Book*)bookForDictionary:(NSDictionary*)dictionary;

@end
