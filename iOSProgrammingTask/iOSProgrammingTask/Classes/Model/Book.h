//
//  Book.h
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 24/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Author, Publisher, Review;

@interface Book : NSManagedObject

@property (nonatomic, retain) NSString * authors;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDecimalNumber * price;
@property (nonatomic, retain) NSString * publishers;
@property (nonatomic, retain) NSDate * releaseDate;
@property (nonatomic, retain) NSString * reviews;
@property (nonatomic, retain) NSSet *author;
@property (nonatomic, retain) NSSet *publisher;
@property (nonatomic, retain) NSSet *review;
@end

@interface Book (CoreDataGeneratedAccessors)

- (void)addAuthorObject:(Author *)value;
- (void)removeAuthorObject:(Author *)value;
- (void)addAuthor:(NSSet *)values;
- (void)removeAuthor:(NSSet *)values;
- (void)addPublisherObject:(Publisher *)value;
- (void)removePublisherObject:(Publisher *)value;
- (void)addPublisher:(NSSet *)values;
- (void)removePublisher:(NSSet *)values;
- (void)addReviewObject:(Review *)value;
- (void)removeReviewObject:(Review *)value;
- (void)addReview:(NSSet *)values;
- (void)removeReview:(NSSet *)values;
@end
