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
@synthesize reviewLabel = _reviewLabel;
@synthesize deleteButton = _deleteButton;
@synthesize priceLabel = _priceLabel;
@synthesize dateLabel = _dateLabel;
@synthesize authorLabel = _authorLabel;
@synthesize publisherLabel = _publisherLabel;
@synthesize book = _book;
@synthesize deleteDelegate = _deleteDelegate;
@synthesize isModal = _isModal;
@synthesize fieldState = _fieldState;
@synthesize isEdit = _isEdit;
@synthesize priceArray = _priceArray;
@synthesize pricePicker =_pricePicker;
@synthesize datePicker = _datePicker;
@synthesize pickerType = _pickerType;
@synthesize authorsArray = _authorsArray;
@synthesize publishersArray = _publishersArray;
@synthesize authorPicker = _authorPicker;
@synthesize publisherPicker = _publisherPicker;
@synthesize selectedAuthor = _selectedAuthor;
@synthesize selectedPublisher = _selectedPublisher;

#pragma mark - View didLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupPage];
    [self setupBooks];
    [self setupNav];
  //  [self setupView];    
    NSArray *numbers = [[[NSArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil]autorelease];
    self.priceArray = numbers;
    
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
    
    
    self.priceLabel.text = [self.book.price stringValue];
    
}

#warning crash occuring on this methid still debugging
-(void)setValueForBooks
{
    self.book.name = self.nameValue.text;

    NSSet *authorSet = [NSSet setWithObject:self.selectedAuthor]; ///// get the vallue which was assign to my propertty at the selected row index
    self.book.authors = authorSet;
    
    NSSet *publisherSet = [NSSet setWithObject:self.selectedPublisher];
    self.book.publishers = publisherSet;
    
    NSDateFormatter *currentDate = [[[NSDateFormatter alloc] init]autorelease];
    [currentDate setDateFormat:@"dd-MM-yyyy"];
    NSDate *dateFromString = [currentDate dateFromString:self.dateLabel.text];
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
    self.authorLabel.text = authorString;
    
    
    NSMutableString *publisherString = [NSMutableString string];
    NSArray *publisherArray = [self.book.publishers allObjects];
    for (Publisher *publisher in publisherArray) {
        [publisherString stringByAppendingFormat:@""];
    }
    self.publisherLabel.text = publisherString;
    
    
    NSMutableString *reviewString = [NSMutableString string];
    NSArray *reviewArray = [self.book.reviews allObjects];
    for (Review *review in reviewArray) {
        [reviewString stringByAppendingFormat:@""];
    }
    self.reviewLabel.text = reviewString;
    
    
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
/////need to test
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameValue) 
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
    [self setValueForBooks];
}

#pragma mark - PricePickerView
-(IBAction)priceButtonPressed
{
    UIActionSheet *menu = [[[UIActionSheet alloc] initWithTitle:@"Please Set a Book Price" delegate:self cancelButtonTitle:@"Done" destructiveButtonTitle:@"Cancel" otherButtonTitles:nil, nil]autorelease];
    
    UIPickerView *pickerView = [[[UIPickerView alloc]initWithFrame:CGRectMake(0, 185, 0, 0)]autorelease];
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    self.pricePicker = pickerView;//assigning the value of the view to the property then using the property to display clicked button at index

    self.pickerType = PricePicker;
    
    [menu addSubview:pickerView];
    [menu showInView:self.view];
    [menu setBounds:CGRectMake(0, 0, 320, 700)];
    
    
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
        }
        else if (self.pickerType == PricePicker)
        {
            NSInteger row1 = [self.pricePicker selectedRowInComponent:0];
            NSInteger row2 = [self.pricePicker selectedRowInComponent:1];
            NSInteger row3 = [self.pricePicker selectedRowInComponent:2];
            NSInteger row4 = [self.pricePicker selectedRowInComponent:3];
            NSString *s1 = [self.priceArray objectAtIndex:row1];
            NSString *s2 = [self.priceArray objectAtIndex:row2];
            NSString *s3 = [self.priceArray objectAtIndex:row3];
            NSString *s4 = [self.priceArray objectAtIndex:row4];
            NSString *stringRow = [NSString stringWithFormat:@"£%@%@.%@%@", s1, s2, s3, s4];
            self.priceLabel.text = stringRow;
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
    if (self.pickerType == PricePicker) 
    {
        return 4;
    }
    else {
        return 1;
    }
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.pickerType == PricePicker) 
    {
        return [self.priceArray count];
    }
    else if (self.pickerType == AuthorPicker) 
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
    if (self.pickerType == PricePicker) 
    {
        return [self.priceArray objectAtIndex:row];
    }
    else if (self.pickerType == AuthorPicker) 
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

//why not being used anymore
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
    self.priceLabel = nil;
    self.dateLabel = nil;
    self.priceArray = nil;
    self.pricePicker = nil;
    self.datePicker = nil;
    self.authorLabel = nil;
    self.publisherLabel = nil;
    self.authorsArray = nil;
    self.publishersArray = nil;
    self.authorPicker = nil;
    self.publisherPicker = nil;
    self.selectedAuthor = nil;
    self.selectedPublisher = nil;
    [super viewDidUnload];
}

- (void)dealloc {
    self.book = nil;
    [super dealloc];
}
@end
