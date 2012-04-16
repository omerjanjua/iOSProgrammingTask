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
    AuthorPicker,
    PublisherPicker
}PickerType;

@interface EditBookViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate>

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UITextField *nameValue;
@property (retain, nonatomic) IBOutlet UITextField *priceValue;
@property (retain, nonatomic) IBOutlet UIButton *deleteButton;
@property (retain, nonatomic) IBOutlet UILabel *dateLabel;
@property (retain, nonatomic) IBOutlet UILabel *authorLabel;
@property (retain, nonatomic) IBOutlet UILabel *publisherLabel;
@property (retain, nonatomic) IBOutlet UILabel *reviewLabel;
@property (nonatomic, retain) NSArray *authorsArray;
@property (nonatomic, retain) NSArray *publishersArray;
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) UIPickerView *authorPicker;
@property (nonatomic, retain) UIPickerView *publisherPicker;
@property (nonatomic, retain) UITextField *textActiveField;
@property (nonatomic, retain) UIView *inputAccessoryView;
@property (nonatomic, retain) UIButton *doneButton;

@property (nonatomic, assign) id <BookDeleteDelegate> deleteDelegate;
@property (nonatomic, assign) PickerType pickerType;
@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, assign) BOOL isModal;
@property (nonatomic, assign) BOOL fieldState;
@property (nonatomic, retain) Book *book;
@property (nonatomic, retain) Author *selectedAuthor;
@property (nonatomic, retain) Publisher *selectedPublisher;

@property (nonatomic, retain) NSDate *releaseDate;

-(IBAction)cancelPressed:(id)sender;
-(IBAction)savePressed:(id)sender;
-(IBAction)removeBookSelected:(id)sender;
-(IBAction)dismissKeyboard;

-(IBAction)dateButtonPressed;
-(IBAction)authorButtonPressed;
-(IBAction)publisherButtonPressed;
-(IBAction)reviewButtonPressed;

@end
