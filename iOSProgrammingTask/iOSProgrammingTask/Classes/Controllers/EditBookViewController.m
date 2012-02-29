//
//  EditBookViewController.m
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 14/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditBookViewController.h"

@interface EditBookViewController ()

//private methods
-(void)setupPage;
-(void)setupBooks;
-(void)setupNav;
-(void)setupInitialBookValues;
-(void)setValueForBooks;
-(void)bookDeleted;
-(void)setupView;
-(void)resetViewPosition;

-(NSString*)validateBooks;

@end

@implementation EditBookViewController
@synthesize scrollView = _scrollView;
@synthesize contentView = _contentView;
@synthesize nameLabel = _nameLabel;
@synthesize nameValue = _nameValue;
@synthesize priceLabel = _priceLabel;
@synthesize priceValue = _priceValue;
@synthesize releaseLabel = _releaseLabel;
@synthesize releaseValue = _releaseValue;
@synthesize authorsLabel = _authorsLabel;
@synthesize authorsValue = _authorsValue;
@synthesize publisherLabel = _publisherLabel;
@synthesize publisherValue = _publisherValue;
@synthesize reviewLabel = _reviewLabel;
@synthesize reviewValue = _reviewValue;
@synthesize deleteButton = _deleteButton;
@synthesize book = _book;
@synthesize deleteDelegate = _deleteDelegate;
@synthesize isModal = _isModal;
@synthesize fieldState = _fieldState;


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupPage];
    [self setupBooks];
    [self setupNav];
    [self setupView];
}

#pragma mark - setup

-(void) setupPage
{
    if (self.isModal) {
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelPressed:)]autorelease];
    self.navigationItem.leftBarButtonItem = cancelButton;
    }
    self.scrollView.contentSize = self.contentView.frame.size;//
}

-(IBAction)cancelPressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)setupView
{
    if (!self.book) {
        self.deleteButton.hidden = YES;
    }
    UITapGestureRecognizer *tap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)]autorelease];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

- (IBAction) dismissKeyboard
{
    [self.nameValue resignFirstResponder];
    [self.priceValue resignFirstResponder];
    [self.releaseValue resignFirstResponder];
    [self.authorsValue resignFirstResponder];
    [self.publisherValue resignFirstResponder];
    [self.reviewValue resignFirstResponder];
    [self setValueForBooks];
}

-(void) setupBooks
{
    self.nameValue.text = self.book.name;
    self.authorsValue.text = self.book.authors;
    self.publisherValue.text = self.book.publishers;
    self.reviewValue.text = self.book.reviews;
        
    NSDateFormatter *currentDate = [[NSDateFormatter alloc] init];
    [currentDate setDateFormat:@"dd-MM-yyyy"];
    NSString *stringFromDate = [currentDate stringFromDate:self.book.releaseDate];
    self.releaseValue.text = stringFromDate;
    
    NSNumberFormatter *numberformatter = [[NSNumberFormatter alloc] init];
    [numberformatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *string = [[NSString alloc] initWithFormat:@"%@", [numberformatter stringFromNumber:self.book.price]];
    self.priceValue.text = string;
    
}

-(void)setValueForBooks
{
    self.book.name = self.nameValue.text;
    //self.book.price = self.priceValue.text;
    //self.book.releaseDate = self.releaseValue.text;
    self.book.authors = self.authorsValue.text;
    self.book.publishers = self.publisherValue.text;
    self.book.reviews = self.reviewValue.text;
    
    NSDateFormatter *currentDate = [[[NSDateFormatter alloc] init]autorelease];
    [currentDate setDateFormat:@"dd-MMMM-yyyy"];
    NSDate *dateFromString = [currentDate dateFromString:self.releaseValue.text];
    self.book.releaseDate = dateFromString;
    
    NSDecimalNumber *decimal = [NSDecimalNumber decimalNumberWithString:self.priceValue.text];
    self.book.price = decimal;
}

-(void)setupInitialBookValues
{
    self.book.name = @"";
//    self.book.price = @"";
//    self.book.releaseDate = @"";
    self.book.authors = @"";
    self.book.publishers = @"";
    self.book.reviews = @"";
    
    NSDateFormatter *currentDate = [[NSDateFormatter alloc] init];
    [currentDate setDateFormat:@"dd-MM-yyyy"];
    NSString *stringFromDate = [currentDate stringFromDate:self.book.releaseDate];
    stringFromDate = @"";
    
    NSNumberFormatter *numberformatter = [[NSNumberFormatter alloc] init];
    [numberformatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *string = [[NSString alloc] initWithFormat:@"%@", [numberformatter stringFromNumber:self.book.price]];
    string = @"";
    
}

-(void)setupNav
{
    UIBarButtonItem *button = [[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(savePressed:)]autorelease];
    self.navigationItem.rightBarButtonItem = button;
}

- (IBAction)savePressed:(id)sender
{
    if (!self.book) {
        Book * book = [Book createEntity];
        self.book = book;
        [self setupInitialBookValues];
    }
    [self setValueForBooks];
    NSString *validate = [self validateBooks];
    if ([validate isEqualToString:@""]) {
        [self.book.managedObjectContext save];
        
        if (self.isModal){
            [self dismissModalViewControllerAnimated:YES];
        }
        else{
            [self.navigationController popViewControllerAnimated:YES];        
        }

    }
    else {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Validate" message:validate delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]autorelease];
        [alert show];
    }
}

#pragma mark - Validate

-(NSString*)validateBooks
{
    if (([self.book.name isEqualToString:@""]) && ([self.book.authors isEqualToString:@""]) && ([self.book.publishers isEqualToString:@""])) {
        return @"can you must enter a title, author and publisher please";
    }
    return @"";
}


#pragma mark - REMOVING CONTACTS
-(IBAction)removeBookSelected:(id)sender
{
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Delete Book" message:@"Are you sure" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"ok", nil]autorelease];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"Delete Book"]) {
        if (buttonIndex == 1) {
            [self.book deleteEntity];
            [self.navigationController dismissModalViewControllerAnimated:YES];
            [self bookDeleted];
        }
    }
    else {
        
    }
}

-(void)bookDeleted
{
    if ([self.deleteDelegate respondsToSelector:@selector(bookDeleted)]) {
        [self.deleteDelegate bookDeleted];
    }
}

#pragma mark - textfield
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameValue) {
        [self.priceValue becomeFirstResponder];
    }
    else if (textField == self.priceValue) {
        [self.releaseValue becomeFirstResponder];
    }
    else if (textField == self.releaseValue) {
        [self.authorsValue becomeFirstResponder];
    }
    else if (textField == self.authorsValue) {
        [self.publisherValue becomeFirstResponder];
    }
    else if (textField == self.publisherValue) {
        [self.reviewValue becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    [self setValueForBooks];

    return NO;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (!self.fieldState) {
        [self resetViewPosition];
    }
    self.fieldState = NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.fieldState = NO;
}

-(void)resetViewPosition
{
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

- (void)viewDidUnload
{
    self.scrollView = nil;
    self.contentView = nil;
    self.nameLabel = nil;
    self.nameValue = nil;
    self.priceLabel = nil;
    self.priceValue = nil;
    self.releaseLabel = nil;
    self.releaseValue = nil;
    self.authorsLabel = nil;
    self.authorsValue = nil;
    self.publisherLabel = nil;
    self.publisherValue = nil;
    self.reviewLabel = nil;
    self.reviewValue = nil;
    self.deleteButton = nil;
    [super viewDidUnload];
}

- (void)dealloc {
    self.book = nil;
    [super dealloc];
}
@end
