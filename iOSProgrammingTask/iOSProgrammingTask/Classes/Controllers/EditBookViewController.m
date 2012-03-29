//
//  EditBookViewController.m
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 14/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditBookViewController.h"
#import "Additions.h"
#import "NSDate+Additions.h"

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
-(void)loadDate;
-(void)loadPrice;

-(BOOL)textFieldisValid:(NSString *)textField;
-(NSString*)validateOrder;

@end

@implementation EditBookViewController
@synthesize scrollView = _scrollView;
@synthesize contentView = _contentView;
@synthesize nameValue = _nameValue;
@synthesize releaseValue = _releaseValue;
@synthesize authorsValue = _authorsValue;
@synthesize publisherValue = _publisherValue;
@synthesize reviewValue = _reviewValue;
@synthesize deleteButton = _deleteButton;
@synthesize priceLabel = _priceLabel;
@synthesize dateLabel = _dateLabel;
@synthesize book = _book;
@synthesize deleteDelegate = _deleteDelegate;
@synthesize isModal = _isModal;
@synthesize fieldState = _fieldState;
@synthesize isEdit = _isEdit;
@synthesize pickerArray = _pickerArray;
@synthesize pickerView = _pickerView;

#pragma mark - View didLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupPage];
    [self setupBooks];
    [self setupNav];
    [self setupView];    
    NSArray *numbers = [[[NSArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil]autorelease];
    self.pickerArray = numbers;
}

#pragma mark - setupBooks

-(void) setupBooks
{
    self.nameValue.text = self.book.name;

    NSMutableString *authorString = [NSMutableString string];
    NSArray *authorArray = [self.book.authors allObjects];
    for (Author *author in authorArray) {
        [authorString appendFormat:@"%@, %@", author.surname, author.firstName];
    }
    self.authorsValue.text = authorString;
    
    
    NSMutableString *publisherString = [NSMutableString string];
    NSArray *publisherArray = [self.book.publishers allObjects];
    for (Publisher *publisher in publisherArray) {
        [publisherString appendFormat:@"%@", publisher.name];
    }
    self.publisherValue.text = publisherString;
    
    
    NSMutableString *reviewString = [NSMutableString string];
    NSArray *reviewArray = [self.book.reviews allObjects];
    for (Review *review in reviewArray) {
        [reviewString appendFormat:@"%@, %@", review.rating];
    }
    self.reviewValue.text = reviewString;
    
    NSDateFormatter *currentDate = [[[NSDateFormatter alloc] init]autorelease];
    [currentDate setDateFormat:@"dd-MM-yyyy"];
    NSString *stringFromDate = [currentDate stringFromDate:self.book.releaseDate];
    self.releaseValue.text = stringFromDate;
    
    
    self.priceLabel.text = [self.book.price stringValue];
    
}

-(void)setValueForBooks
{
    self.book.name = self.nameValue.text;
    #warning 
    NSMutableSet *authorSet = [NSMutableSet set]; /////
    NSArray *authorArray = [self.book.authors allObjects];
    for (Author *author in authorArray) {
        [authorSet addObject:self.authorsValue.text];
    }
    self.book.authors = authorSet;

    NSMutableSet *publisherSet = [NSMutableSet set];
    NSArray *publisherArray = [self.book.publishers allObjects];
    for (Publisher *publisher in publisherArray) {
        [publisherSet addObject:self.publisherValue.text];
    }
    self.book.publishers = publisherSet;
    
    NSMutableSet *reviewSet = [NSMutableSet set];
    NSArray *reviewArray = [self.book.reviews allObjects];
    for (Review *review in reviewArray) {
        [reviewSet addObject:self.reviewValue.text];
    }
    self.book.reviews = reviewSet;
    
    
    NSDateFormatter *currentDate = [[[NSDateFormatter alloc] init]autorelease];
    [currentDate setDateFormat:@"dd-MM-yyyy"];
    NSDate *dateFromString = [currentDate dateFromString:self.releaseValue.text];
    self.book.releaseDate = dateFromString;
    
    NSDecimalNumber *decimal = [NSDecimalNumber decimalNumberWithString:self.priceLabel.text];
    self.book.price = decimal;
}

-(void)setupInitialBookValues
{
    self.book.name = @"";

    NSMutableString *authorString = [NSMutableString string];
    NSArray *authorArray = [self.book.authors allObjects];
    for (Author *author in authorArray) {
        [authorString stringByAppendingFormat:@""];
    }
    self.authorsValue.text = authorString;
    
    
    NSMutableString *publisherString = [NSMutableString string];
    NSArray *publisherArray = [self.book.publishers allObjects];
    for (Publisher *publisher in publisherArray) {
        [publisherString stringByAppendingFormat:@""];
    }
    self.publisherValue.text = publisherString;
    
    
    NSMutableString *reviewString = [NSMutableString string];
    NSArray *reviewArray = [self.book.reviews allObjects];
    for (Review *review in reviewArray) {
        [reviewString stringByAppendingFormat:@""];
    }
    self.reviewValue.text = reviewString;
    
    
    self.book.releaseDate = Nil;
    self.book.price = Nil;
}

#pragma mark - cancelPressed
-(void) setupPage
{
    if (self.isModal) {
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelPressed:)]autorelease];
    self.navigationItem.leftBarButtonItem = cancelButton;
    }
    self.scrollView.contentSize = self.contentView.frame.size;
}

-(IBAction)cancelPressed:(id)sender
{
    [self.book.managedObjectContext reset];
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - savePressed
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
    NSString *validate = [self validateOrder];
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

-(BOOL)textFieldisValid:(NSString *)textField
{
    BOOL textFieldisEmpty = textField != Nil;
    BOOL textFieldisNil = textField != Nil;
    
    return (textFieldisEmpty && textFieldisNil);    
}

-(NSString*)validateOrder
{
    NSMutableString *authorString = [NSMutableString string];
    NSArray *authorArray = [self.book.authors allObjects];
    for (Author *author in authorArray) {
        [authorString stringByAppendingFormat:@""];
    }
    
    
    NSMutableString *publisherString = [NSMutableString string];
    NSArray *publisherArray = [self.book.publishers allObjects];
    for (Publisher *publisher in publisherArray) {
        [publisherString stringByAppendingFormat:@""];
    }
    
    if ((![self textFieldisValid:self.book.name]) || (![self textFieldisValid:authorString]) || (![self textFieldisValid:publisherString])) {
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
    [self.priceLabel resignFirstResponder];
    [self.releaseValue resignFirstResponder];
    [self.authorsValue resignFirstResponder];
    [self.publisherValue resignFirstResponder];
    [self.reviewValue resignFirstResponder];
#warning  /////  [self setValueForBooks];
}

#pragma mark - PickerView
-(IBAction)priceButtonPressed
{
    NSInteger row1 = [self.pickerView selectedRowInComponent:0];
    NSInteger row2 = [self.pickerView selectedRowInComponent:1];
    NSInteger row3 = [self.pickerView selectedRowInComponent:2];
    NSInteger row4 = [self.pickerView selectedRowInComponent:3];
    
    
    NSString *s1 = [self.pickerArray objectAtIndex:row1];
    NSString *s2 = [self.pickerArray objectAtIndex:row2];
    NSString *s3 = [self.pickerArray objectAtIndex:row3];
    NSString *s4 = [self.pickerArray objectAtIndex:row4];
    
    NSString *stringRow = [NSString stringWithFormat:@"£%@%@.%@%@", s1, s2, s3, s4];
    
    self.priceLabel.text = stringRow;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerArray count];
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerArray objectAtIndex:row];
}

-(IBAction)dateButtonPressed
{
   // [ActionSheetPicker displayActionPickerWithView:self.view datePickerMode:UIDatePickerModeDate selectedDate:self.book.releaseDate target:self action:@selector(dateSelected:) title:@"Date select"];
}

-(void)dateSelected: (NSDate *)selectedDate
{
    self.book.releaseDate = selectedDate;
    if (self.isEdit) {[self.book.managedObjectContext save];}
    [self loadDate];
}
     
-(void)priceSelected: (NSDecimalNumber *)selectedPrice
{
    self.book.price = selectedPrice;
    if (self.isEdit) {
        [self.book.managedObjectContext save];}
    [self loadPrice];
}

-(void)loadDate
{
    NSString *dateString = [NSDate stringFromDateWithFormat:self.book.releaseDate format:@"dd/MM/yyyy"];
    self.dateLabel.text = [NSString stringWithFormat:@"%@", dateString];
}
     
-(void)loadPrice
{
    NSString *priceString = [self.book.price stringValue];
    NSString *format = [[[NSString alloc]initWithFormat:@"%@", priceString]autorelease];
    self.priceLabel.text = format;
}

#pragma mark - unload+dealloc

- (void)viewDidUnload
{
    self.scrollView = nil;
    self.contentView = nil;
    self.nameValue = nil;
    self.releaseValue = nil;
    self.authorsValue = nil;
    self.publisherValue = nil;
    self.reviewValue = nil;
    self.deleteButton = nil;
    self.priceLabel = nil;
    self.dateLabel = nil;
    self.pickerView = nil;
    self.pickerArray = nil;
    [super viewDidUnload];
}

- (void)dealloc {
    self.book = nil;
    [super dealloc];
}
@end
