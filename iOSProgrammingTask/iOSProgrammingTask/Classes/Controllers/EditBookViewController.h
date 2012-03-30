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

typedef enum {
    DatePicker,
    PricePicker
}PickerType;

@interface EditBookViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate>

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UITextField *nameValue;
@property (retain, nonatomic) IBOutlet UITextField *authorsValue;
@property (retain, nonatomic) IBOutlet UITextField *publisherValue;
@property (retain, nonatomic) IBOutlet UITextField *reviewValue;
@property (retain, nonatomic) IBOutlet UIButton *deleteButton;
@property (retain, nonatomic) IBOutlet UILabel *priceLabel;
@property (retain, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) NSArray *pickerArray;
@property (nonatomic, retain) UIPickerView *pickerView;
@property (nonatomic, retain) UIDatePicker *datePicker;

@property (nonatomic, assign) id <BookDeleteDelegate> deleteDelegate;
@property (nonatomic, assign) PickerType pickerType;
@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, assign) BOOL isModal;
@property (nonatomic, assign) BOOL fieldState;
@property (nonatomic, retain) Book *book;

-(IBAction)cancelPressed:(id)sender;
-(IBAction)savePressed:(id)sender;
-(IBAction)removeBookSelected:(id)sender;
-(IBAction)dismissKeyboard;

-(IBAction)priceButtonPressed;
-(IBAction)dateButtonPressed;

@end
