//
//  IterationHelper.h
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 23/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"

@interface IterationHelper : NSObject

-(void)authorValuetoTextField;
-(void)publisherValuetoTextField;
-(void)ReviewValuetoTextField;
-(void)emptyStringtoAuthor;
-(void)emptyStringtoPublisher;
-(void)emptyStringtoReview;

@property (nonatomic, retain) Book *book;

@end
