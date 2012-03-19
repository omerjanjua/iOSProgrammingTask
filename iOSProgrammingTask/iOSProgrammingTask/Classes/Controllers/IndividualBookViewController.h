//
//  IndividualBookViewController.h
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 24/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"
#import "BookDeleteDelegate.h"

@interface IndividualBookViewController : UIViewController <BookDeleteDelegate>

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UILabel *nameValue;
@property (retain, nonatomic) IBOutlet UILabel *priceValue;
@property (retain, nonatomic) IBOutlet UILabel *releaseValue;
@property (retain, nonatomic) IBOutlet UILabel *authorValue;
@property (retain, nonatomic) IBOutlet UILabel *publisherValue;
@property (retain, nonatomic) IBOutlet UILabel *reviewValue;

@property (nonatomic, retain) Book *book;

@end
