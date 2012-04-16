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
#import "AddReviewViewController.h"

@interface EditBookViewController ()

//private methods
-(void)setupPage;
-(void)setupBooks;
-(void)setupNav;
-(void)setValueForBooks;
-(void)bookDeleted;
-(void)setupView;
-(void)resetViewPosition;
-(void)loadDate;
-(void)loadPrice;
-(void)createInputAccessoryView;

-(BOOL)textFieldisValid:(NSString *)textField;
-(NSString*)validateOrder;

@end

@implementation EditBookViewController
@synthesize scrollView = _scrollView;
@synthesize contentView = _contentView;
@synthesize nameValue = _nameValue;
@synthesize reviewLabel = _reviewLabel;
@synthesize deleteButton = _deleteButton;
@synthesize priceValue =_priceValue;
@synthesize dateLabel = _dateLabel;
@synthesize authorLabel = _authorLabel;
@synthesize publisherLabel = _publisherLabel;
@synthesize book = _book;
@synthesize deleteDelegate = _deleteDelegate;
@synthesize isModal = _isModal;
@synthesize fieldState = _fieldState;
@synthesize isEdit = _isEdit;
@synthesize datePicker = _datePicker;
@synthesize pickerType = _pickerType;
@synthesize authorsArray = _authorsArray;
@synthesize publishersArray = _publishersArray;
@synthesize authorPicker = _authorPicker;
@synthesize publisherPicker = _publisherPicker;
@synthesize selectedAuthor = _selectedAuthor;
@synthesize selectedPublisher = _selectedPublisher;
@synthesize textActiveField = _textActiveField;
@synthesize inputAccessoryView = _inputAccessoryView;
@synthesize doneButton = _doneButton;
@synthesize releaseDate = _releaseDate;

#pragma mark - View didLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupPage];
    [self setupBooks];
    [self setupNav];
  //  [self setupView];    
    
    self.authorsArray = [Author findAll];//looking for all authors instead of authors in my book property//todo
    self.publishersArray = [Publisher findAll];
    //self.publishersArray = [self.book.publishers allObjects];
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
    self.authorLabel.text = authorString;
    
    
    NSMutableString *publisherString = [NSMutableString string];
    NSArray *publisherArray = [self.book.publishers allObjects];
    for (Publisher *publisher in publisherArray) {
        [publisherString appendFormat:@"%@", publisher.name];
    }
    self.publisherLabel.text = publisherString;
    
    
    NSMutableString *reviewString = [NSMutableString string];
    NSArray *reviewArray = [self.book.reviews allObjects];
    for (Review *review in reviewArray) {
        [reviewString appendFormat:@"%@, %@", review.rating];
    }
    self.reviewLabel.text = reviewString;
    
    NSDateFormatter *currentDate = [[[NSDateFormatter alloc] init]autorelease];
    [currentDate setDateFormat:@"dd-MM-yyyy"];
    NSString *stringFromDate = [currentDate stringFromDate:self.book.releaseDate];
    self.dateLabel.text = stringFromDate;
    
    
    self.priceValue.text = [self.book.price stringValue];
    
}

#warning crash occuring on this methid still debugging TODO//comments below
//values should be collected from the model not the UI ie textfields
//sort out the intial set up value becuase at the moment it is nil and only has a value when you manually set it form the pickerview eg you cannot just click save without choosing anything
-(void)setValueForBooks
{
    self.book.name = self.nameValue.text;

    NSSet *authorSet = [NSSet setWithObject:self.selectedAuthor]; ///// get the vallue which was assign to my property at the selected row index
    self.book.authors = authorSet;
    
    NSSet *publisherSet = [NSSet setWithObject:self.selectedPublisher];
    self.book.publishers = publisherSet;
    
    
    //saving the date in the model at clicked button at index
    
//    NSDateFormatter *currentDate = [[[NSDateFormatter alloc] init]autorelease];
//    [currentDate setDateFormat:@"dd-MM-yyyy"];
//    NSDate *dateFromString = [currentDate dateFromString:self.dateLabel.text];
//    self.book.releaseDate = dateFromString;
    self.book.releaseDate = self.releaseDate;
    
    NSDecimalNumber *decimal = [NSDecimalNumber decimalNumberWithString:self.priceValue.text];
    self.book.price = decimal;
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
    //dont need this anymore as the values are being called from the model 
//    if (!self.book) {
//        Book * book = [Book createEntity];
//        self.book = book;
//        [self setupInitialBookValues];
//    }
    
    NSString *validate = [self validateOrder];
    if ([validate isEqualToString:@""]) {
        [self setValueForBooks];
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
        return @"can you enter a title, author and publisher please";
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
    if ([alertView.title isEqualToString:@"Delete Book"]) 
    {
        if (buttonIndex == 1) 
        {
            [self.book deleteEntity];
            [self.navigationController dismissModalViewControllerAnimated:YES];
            [self bookDeleted];
        }
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
    if (textField == self.nameValue) 
    {
        [self.priceValue becomeFirstResponder];
//        [self.scrollView setContentOffset:CGPointMake(0, 120) animated:YES];
    }
    
    else if (textField == self.priceValue) 
    {
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
    [self createInputAccessoryView];
    [textField setInputAccessoryView:self.inputAccessoryView];
    self.textActiveField = textField;
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
    [self.priceValue resignFirstResponder];
    [self setValueForBooks];
}


#pragma mark - PriceKeyboard
-(void)createInputAccessoryView
{
    self.inputAccessoryView = [[[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 310.0, 40.0)]autorelease];
    [self.inputAccessoryView setBackgroundColor:[UIColor lightGrayColor]];
    [self.inputAccessoryView setAlpha:0.8];
    self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.doneButton setFrame:CGRectMake(240.0, 0.0f, 80.0f, 40.0f)];
    [self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [self.doneButton setBackgroundColor:[UIColor greenColor]];
    [self.doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.doneButton addTarget:self action:@selector(doneTyping) forControlEvents:UIControlEventTouchUpInside];
    [self.inputAccessoryView addSubview:self.doneButton];
    self.priceValue.keyboardType = UIKeyboardTypeDecimalPad;
}

-(void)doneTyping
{
    [self.textActiveField resignFirstResponder];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) 
    {        
        if (self.pickerType == DatePicker) 
        {
            NSDate *date = [self.datePicker date];            
            NSString *dateString = [NSDate stringFromDateWithFormat:date format:@"dd/MM/yyyy"];
            self.dateLabel.text = [NSString stringWithFormat:@"%@", dateString];
            
            //saving to the model
            self.releaseDate = [NSDate dateFromStringWithFormat:dateString format:@"dd/MM/yyyy"]; //hit
        }
        else if (self.pickerType == AuthorPicker) {            
            NSInteger row = [self.authorPicker selectedRowInComponent:0];
            Author *author = [self.authorsArray objectAtIndex:row];
            self.selectedAuthor = author;//assign to selected property for when saving to the NSSET later on
            NSString *string = [NSString stringWithFormat:@"%@ %@", author.firstName, author.surname];
            self.authorLabel.text = string;
            
        }
        else if (self.pickerType == PublisherPicker) {
            NSInteger row = [self.publisherPicker selectedRowInComponent:0];
            Publisher *publisher = [self.publishersArray objectAtIndex:row];
            self.selectedPublisher = publisher;
            NSString *string = publisher.name;//can assign this directly to the label but keeping the variable for debugging purposes.
            self.publisherLabel.text = string;
        }
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.pickerType == AuthorPicker) 
    {
        return [self.authorsArray count];
    }
    else if (self.pickerType == PublisherPicker) 
    {
        return [self.publishersArray count];
    }
    else 
    {
        return 0;
    }
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.pickerType == AuthorPicker) 
    {
        Author *author = [self.authorsArray objectAtIndex:row];
        NSString *string = [NSString stringWithFormat:@"%@ %@", author.firstName, author.surname];
        return string;//instead of getting the entire object returnung the property of firstname instead.
    }
    else if (self.pickerType == PublisherPicker) 
    {
        Publisher *publisher = [self.publishersArray objectAtIndex:row];
        return publisher.name;
    }
    else 
    {
        return 0;
    }
}

#pragma mark - DatePickerView
-(IBAction)dateButtonPressed
{
    UIActionSheet *menu = [[[UIActionSheet alloc] initWithTitle:@"Please select a release date" delegate:self cancelButtonTitle:@"Done" destructiveButtonTitle:@"Cancel" otherButtonTitles:nil, nil]autorelease];
    
    UIDatePicker *datePicker = [[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 185, 0, 0)]autorelease];
    
    self.datePicker = datePicker;//assigning the value of the view to the property
    [datePicker setDatePickerMode:UIDatePickerModeDate];//only showing date
    self.pickerType = DatePicker;//setting the enum to the property
    [menu addSubview:datePicker];
    [menu showInView:self.view];
    [menu setBounds:CGRectMake(0, 0, 320, 700)];
    
    
}

#warning what are these methods down here are they een being called anymore
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
    self.priceValue.text = format;
}

#pragma mark - AuthorPickerView
-(IBAction)authorButtonPressed
{
    UIActionSheet *menu = [[[UIActionSheet alloc] initWithTitle:@"Please Set a Book Price" delegate:self cancelButtonTitle:@"Done" destructiveButtonTitle:@"Cancel" otherButtonTitles:nil, nil]autorelease];
    
    UIPickerView *pickerView = [[[UIPickerView alloc]initWithFrame:CGRectMake(0, 185, 0, 0)]autorelease];
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    self.authorPicker = pickerView;
   
    self.pickerType = AuthorPicker;

    [menu addSubview:pickerView];
    [menu showInView:self.view];
    [menu setBounds:CGRectMake(0, 0, 320, 700)];
    
}

#pragma mark - PublisherPickerView
-(IBAction)publisherButtonPressed
{
    UIActionSheet *menu = [[[UIActionSheet alloc] initWithTitle:@"Please Set a Book Price" delegate:self cancelButtonTitle:@"Done" destructiveButtonTitle:@"Cancel" otherButtonTitles:nil, nil]autorelease];
    
    UIPickerView *pickerView = [[[UIPickerView alloc]initWithFrame:CGRectMake(0, 185, 0, 0)]autorelease];
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    self.publisherPicker = pickerView;//assigning the value of the view to the property then using the property to display clicked button at index
    
    self.pickerType = PublisherPicker;//call this before its added to the subview so the enum is assigned properly
    
    [menu addSubview:pickerView];
    [menu showInView:self.view];
    [menu setBounds:CGRectMake(0, 0, 320, 700)];    
}


#pragma mark - Review 
-(IBAction)reviewButtonPressed
{
    AddReviewViewController *controller = [[[AddReviewViewController alloc] initWithNibName:@"AddReviewView" bundle:Nil]autorelease];
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - unload+dealloc
- (void)viewDidUnload
{
    self.scrollView = nil;
    self.contentView = nil;
    self.nameValue = nil;
    self.reviewLabel = nil;
    self.deleteButton = nil;
    self.priceValue = nil;
    self.dateLabel = nil;
    self.datePicker = nil;
    self.authorLabel = nil;
    self.publisherLabel = nil;
    self.authorsArray = nil;
    self.publishersArray = nil;
    self.authorPicker = nil;
    self.publisherPicker = nil;
    self.selectedAuthor = nil;
    self.selectedPublisher = nil;
    self.textActiveField = nil;
    self.inputAccessoryView = nil;
    self.doneButton = nil;
    self.releaseDate = nil;
    [super viewDidUnload];
}

- (void)dealloc {
    self.book = nil;
    self.selectedAuthor = nil;
    self.selectedPublisher = nil;
    [super dealloc];
}
@end
