//
//  AddReviewViewController.m
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 04/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddReviewViewController.h"

@interface AddReviewViewController ()

-(void)setupPage;
-(void)setupView;
-(void)setupNav;
-(void)setupInitialReviewValue;
-(void)setValueForReview;
-(void)setupReview;
-(NSString*)validateReview;

@end

@implementation AddReviewViewController
@synthesize titleLabel = _titleLabel;
@synthesize titleValue = _titleValue;
@synthesize ratingLabel = _ratingLabel;
@synthesize ratingValue = _ratingValue;
@synthesize commentLabel = _commentLabel;
@synthesize commentValue = _commentValue;
@synthesize isModal = _isModal;
@synthesize review = _review;
@synthesize fieldState = _fieldState;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupPage];
    [self setupView];
    [self setupNav];
    [self setupReview];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - setup

-(void) setupPage
{
    if (self.isModal) {
        UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelPressed:)]autorelease];
        self.navigationItem.leftBarButtonItem = cancelButton;
    }
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

-(void)setupReview
{
    self.titleValue.text = self.review.title;
    self.commentValue.text = self.review.comment;
    
    NSNumberFormatter *numberformatter = [[NSNumberFormatter alloc] init];
    [numberformatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *string = [[NSString alloc] initWithFormat:@"%@", [numberformatter stringFromNumber:self.review.rating]];
    self.ratingValue.text = string;
}

-(void)setValueForReview
{
    self.review.title = self.titleValue.text;
    self.review.comment = self.commentValue.text;
    
    NSDecimalNumber *decimal = [NSDecimalNumber decimalNumberWithString:self.ratingValue.text];
    self.review.rating = decimal;
}

-(void)setupInitialReviewValue
{
    self.review.title = @"";
    self.review.comment = @"";
    
    NSDecimalNumber *decimal = [NSDecimalNumber decimalNumberWithString:@""];
    self.review.rating = decimal;
}

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

-(NSString*)validateReview
{
    NSNumberFormatter *numberformatter = [[NSNumberFormatter alloc] init];
    [numberformatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *string = [[NSString alloc] initWithFormat:@"%@", [numberformatter stringFromNumber:self.review.rating]];
    
    if (([self.review.title isEqualToString:@""]) && ([string isEqualToString:@""])) {
        return @"can you must enter a title and rating please";
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

- (void)viewDidUnload
{
    self.titleLabel = nil;
    self.titleValue = nil;
    self.ratingLabel = nil;
    self.ratingValue = nil;
    self.commentLabel = nil;
    self.commentValue = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    self.review = nil;
    [super dealloc];
}
@end
