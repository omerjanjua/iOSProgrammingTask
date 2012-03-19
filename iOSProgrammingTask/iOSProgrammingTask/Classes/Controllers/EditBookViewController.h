//
//  EditBookViewController.h
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 14/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"
#import "BookDeleteDelegate.h"

@interface EditBookViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UITextField *nameValue;
@property (retain, nonatomic) IBOutlet UITextField *priceValue;
@property (retain, nonatomic) IBOutlet UITextField *releaseValue;
@property (retain, nonatomic) IBOutlet UITextField *authorsValue;
@property (retain, nonatomic) IBOutlet UITextField *publisherValue;
@property (retain, nonatomic) IBOutlet UITextField *reviewValue;
@property (retain, nonatomic) IBOutlet UIButton *deleteButton;

@property (nonatomic, assign) id <BookDeleteDelegate> deleteDelegate;

@property (nonatomic, assign) BOOL isModal;
@property (nonatomic, assign) BOOL fieldState;
@property (nonatomic, retain) Book *book;

-(IBAction)cancelPressed:(id)sender;
-(IBAction)savePressed:(id)sender;
-(IBAction)removeBookSelected:(id)sender;
-(IBAction)dismissKeyboard;

@end
