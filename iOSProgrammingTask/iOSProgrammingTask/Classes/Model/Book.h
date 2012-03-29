//
//  Book.h
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 27/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Author, Publisher, Review;

@interface Book : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDecimalNumber * price;
@property (nonatomic, retain) NSDate * releaseDate;
@property (nonatomic, retain) NSSet *authors;
@property (nonatomic, retain) NSSet *publishers;
@property (nonatomic, retain) NSSet *reviews;
@end

@interface Book (CoreDataGeneratedAccessors)

- (void)addAuthorsObject:(Author *)value;
- (void)removeAuthorsObject:(Author *)value;
- (void)addAuthors:(NSSet *)values;
- (void)removeAuthors:(NSSet *)values;
- (void)addPublishersObject:(Publisher *)value;
- (void)removePublishersObject:(Publisher *)value;
- (void)addPublishers:(NSSet *)values;
- (void)removePublishers:(NSSet *)values;
- (void)addReviewsObject:(Review *)value;
- (void)removeReviewsObject:(Review *)value;
- (void)addReviews:(NSSet *)values;
- (void)removeReviews:(NSSet *)values;
@end
