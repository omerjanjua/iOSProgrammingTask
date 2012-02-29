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

@interface IndividualBookViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate, BookDeleteDelegate>

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UILabel *nameValue;
@property (retain, nonatomic) IBOutlet UILabel *priceLabel;
@property (retain, nonatomic) IBOutlet UILabel *priceValue;
@property (retain, nonatomic) IBOutlet UILabel *releaseLabel;
@property (retain, nonatomic) IBOutlet UILabel *releaseValue;
@property (retain, nonatomic) IBOutlet UILabel *authorLabel;
@property (retain, nonatomic) IBOutlet UILabel *authorValue;
@property (retain, nonatomic) IBOutlet UILabel *publisherLabel;
@property (retain, nonatomic) IBOutlet UILabel *publisherValue;
@property (retain, nonatomic) IBOutlet UILabel *reviewLabel;
@property (retain, nonatomic) IBOutlet UILabel *reviewValue;

@property (nonatomic, assign) BOOL isModal;
@property (nonatomic, retain) Book *book;

-(IBAction)savePressed:(id)sender;
-(IBAction)cancelPressed:(id)sender;

@end
