//
//  Review.h
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 27/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Book;

@interface Review : NSManagedObject

@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) Book *bookReview;

@end
