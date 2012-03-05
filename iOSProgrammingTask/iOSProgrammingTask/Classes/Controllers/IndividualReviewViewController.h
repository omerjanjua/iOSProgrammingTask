//
//  IndividualReviewViewController.h
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 02/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Review.h"

@interface IndividualReviewViewController : UIViewController

@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *ratingLabel;
@property (retain, nonatomic) IBOutlet UITextView *commentsTextview;

@property (nonatomic, assign) BOOL isModal;
@property (nonatomic, retain) Review *review;

@end
