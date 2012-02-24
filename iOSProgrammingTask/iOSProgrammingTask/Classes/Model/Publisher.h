//
//  Publisher.h
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 24/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Book;

@interface Publisher : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Book *bookPublisher;

@end
