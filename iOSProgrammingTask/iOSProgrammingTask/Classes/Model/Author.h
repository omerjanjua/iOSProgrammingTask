//
//  Author.h
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 22/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Book;

@interface Author : NSManagedObject

@property (nonatomic, retain) NSDate * dob;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * surname;
@property (nonatomic, retain) NSSet *bookAuthor;
@end

@interface Author (CoreDataGeneratedAccessors)

- (void)addBookAuthorObject:(Book *)value;
- (void)removeBookAuthorObject:(Book *)value;
- (void)addBookAuthor:(NSSet *)values;
- (void)removeBookAuthor:(NSSet *)values;
@end
