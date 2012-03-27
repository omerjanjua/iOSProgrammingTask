//
//  AddReviewViewController.m
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 04/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddReviewViewController.h"

@interface AddReviewViewController ()

-(void)setupCancel;
-(void)setupView;
-(void)setupNav;
-(void)setupInitialReviewValue;
-(void)setValueForReview;
-(void)setupReview;

-(BOOL)textFieldisValid:(NSString *)textField;
-(NSString*)validateReview;

@end

@implementation AddReviewViewController
@synthesize scrollView = _scrollView;
@synthesize contentView = _contentView;
@synthesize titleValue = _titleValue;
@synthesize ratingValue = _ratingValue;
@synthesize commentValue = _commentValue;
@synthesize isModal = _isModal;
@synthesize review = _review;
@synthesize fieldState = _fieldState;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupCancel];
    [self setupView];
    [self setupNav];
    [self setupReview];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - setupReview
-(void)setupReview
{
    self.commentValue.text = self.review.comment;
    self.ratingValue.text = [self.review.rating stringValue];
}

-(void)setValueForReview
{
    self.review.comment = self.commentValue.text;
    
    NSDecimalNumber *decimal = [NSDecimalNumber decimalNumberWithString:self.ratingValue.text];
    self.review.rating = decimal;
}

-(void)setupInitialReviewValue
{
    self.review.comment = @"";
    
    NSDecimalNumber *decimal = [NSDecimalNumber decimalNumberWithString:@""];
    self.review.rating = decimal;
}

#pragma mark - setupCancel
-(void) setupCancel
{
    if (self.isModal) {
        UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelPressed:)]autorelease];
        self.navigationItem.leftBarButtonItem = cancelButton;
    }
    self.scrollView.contentSize = self.contentView.frame.size;
}

-(IBAction)cancelPressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)setupView
{
    UITapGestureRecognizer *tap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)]autorelease];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

-(IBAction) dismissKeyboard
{
    [self.titleValue resignFirstResponder];
    [self.ratingValue resignFirstResponder];
    [self.commentValue resignFirstResponder];
    [self setValueForReview];
}


#pragma mark - setupSave
-(void)setupNav
{
    UIBarButtonItem *button = [[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(savePressed:)]autorelease];
    self.navigationItem.rightBarButtonItem = button;
}

-(IBAction)savePressed:(id)sender
{
    if (!self.review) {
        Review * review = [Review createEntity];
        self.review = review;
        [self setupInitialReviewValue];
    }   
    [self setValueForReview];
    NSString *validate = [self validateReview];
    if ([validate isEqualToString:@""]) {
        [self.review.managedObjectContext save];
        
        if (self.isModal) {
            [self dismissModalViewControllerAnimated:YES];
        }
        else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Validate" message:validate delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]autorelease];
        [alert show];
    }
}

#pragma mark - Validate

-(BOOL)textFieldisValid:(NSString *)textField
{
    BOOL textFieldisNil = textField != Nil;
    BOOL textFieldisEmpty = textField != Nil;
    
    return (textFieldisEmpty && textFieldisNil);
}

-(NSString*)validateReview
{
    if ((![self textFieldisValid:[self.review.rating stringValue]])) {
        return @"can you must enter a rating please";
    }
    return @"";
}

#pragma mark - textfield
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.titleValue) {
        [self.ratingValue becomeFirstResponder];
    }    
    else if (textField == self.ratingValue) {
        [self.commentValue becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    [self setValueForReview];
    
    return NO;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (!self.fieldState) {
    }
    self.fieldState = NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.fieldState = NO;
}

#pragma mark - unload
- (void)viewDidUnload
{
    self.titleValue = nil;
    self.ratingValue = nil;
    self.commentValue = nil;
    self.scrollView = nil;
    self.contentView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    self.review = nil;
    [super dealloc];
}
@end
