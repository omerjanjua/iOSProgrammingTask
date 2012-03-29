//
//  Publisher.h
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 27/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Book;

@interface Publisher : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *bookPublisher;
@end

@interface Publisher (CoreDataGeneratedAccessors)

- (void)addBookPublisherObject:(Book *)value;
- (void)removeBookPublisherObject:(Book *)value;
- (void)addBookPublisher:(NSSet *)values;
- (void)removeBookPublisher:(NSSet *)values;
@end
