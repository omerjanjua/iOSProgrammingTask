//
//  AddReviewViewController.h
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 04/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Review.h"

@interface AddReviewViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UITextField *titleValue;
@property (retain, nonatomic) IBOutlet UITextField *ratingValue;
@property (retain, nonatomic) IBOutlet UITextView *commentValue;

@property (nonatomic, assign) BOOL isModal;
@property (nonatomic, assign) BOOL fieldState;
@property (nonatomic, retain) Review *review;

-(IBAction)cancelPressed:(id)sender;
-(IBAction)savePressed:(id)sender;
-(IBAction)dismissKeyboard;
@end
