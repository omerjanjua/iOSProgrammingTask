//
//  IndividualBookViewController.m
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 24/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IndividualBookViewController.h"
#import "BookViewController.h"
#import "EditBookViewController.h"

@interface IndividualBookViewController ()

-(void)setupPage;
-(void)setupBooks;
-(void)setupInitialBookValues;
-(void)setupNav;
-(void)setValueForBooks;
-(NSString*)validateBooks;

@end

@implementation IndividualBookViewController
@synthesize scrollView = _scrollView;
@synthesize contentView = _contentView;
@synthesize nameLabel = _nameLabel;
@synthesize nameValue = _nameValue;
@synthesize priceLabel = _priceLabel;
@synthesize priceValue = _priceValue;
@synthesize releaseLabel = _releaseLabel;
@synthesize releaseValue = _releaseValue;
@synthesize authorLabel = _authorLabel;
@synthesize authorValue = _authorValue;
@synthesize publisherLabel = _publisherLabel;
@synthesize publisherValue = _publisherValue;
@synthesize reviewLabel = _reviewLabel;
@synthesize reviewValue = _reviewValue;
@synthesize book = _book;
@synthesize isModal = _isModal;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - setupView

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupPage];
    [self setupNav];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupBooks];
}

#pragma mark - Save
-(IBAction)savePressed:(id)sender
{
    [self setValueForBooks];
    NSString *validate = [self validateBooks];
    if ([validate isEqualToString:@""]) {
        [self.book.managedObjectContext save];
        if (self.isModal) {
            [self dismissModalViewControllerAnimated:YES];
        }
    }
    else {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Validate" message:validate delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]autorelease];
        [alert show];
    }
}

#pragma mark - setup

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
    [self dismissModalViewControllerAnimated:YES];
}

-(void) setupBooks
{
    if (!self.book) {
        Book *book = [Book createEntity];
        self.book = book;
        [self setupInitialBookValues];
    }
    
    self.nameValue.text = self.book.name;
    self.authorValue.text = self.book.authors;
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

-(void)setupInitialBookValues
{
    self.book.name = @"";
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

#pragma mark - edit

-(void)setupNav
{
    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
    UIBarButtonItem *button = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed:)]autorelease];
    self.navigationItem.rightBarButtonItem = button;
}

-(IBAction)editButtonPressed:(id)sender
{
    EditBookViewController *controller = [[[EditBookViewController alloc] initWithNibName:@"EditBookView" bundle:nil]autorelease];
    controller.book = self.book;
    controller.deleteDelegate = self;
    controller.isModal = YES;
    
    UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController:controller]autorelease];
    [self.navigationController presentModalViewController:navController animated:YES];
}

#pragma mark - setup book values

-(void)setValueForBooks
{
    self.book.name = self.nameValue.text;
    self.book.authors = self.authorValue.text;
    self.book.publishers = self.publisherValue.text;
    self.book.reviews = self.reviewValue.text;
    
    NSDateFormatter *currentDate = [[[NSDateFormatter alloc] init]autorelease];
    [currentDate setDateFormat:@"dd-MMMM-yyyy"];
    NSDate *dateFromString = [currentDate dateFromString:self.releaseValue.text];
    self.book.releaseDate = dateFromString;
    
    NSDecimalNumber *decimal = [NSDecimalNumber decimalNumberWithString:self.priceValue.text];
    self.book.price = decimal;


}

#pragma mark - Validate

-(NSString*)validateBooks
{
    if (([self.book.name isEqualToString:@""]) && ([self.book.authors isEqualToString:@""]) && ([self.book.publishers isEqualToString:@""])) {
        return @"can you must enter a title, author and publisher please";
    }
    return @"";
}   


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"Delete Book"]) {
        if (buttonIndex == 1) {
            [self.book deleteEntity];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else {
        
    }
}


#pragma mark - dealloc and unload

- (void)viewDidUnload
{
    [self dealloc];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    self.scrollView = nil;
    self.contentView = nil;
    self.nameLabel = nil;
    self.nameValue = nil;
    self.priceLabel = nil;
    self.priceValue = nil;
    self.releaseLabel = nil;
    self.releaseValue = nil;
    self.authorLabel = nil;
    self.authorValue = nil;
    self.publisherLabel = nil;
    self.publisherValue = nil;
    self.reviewLabel = nil;
    self.reviewValue = nil;
    [super dealloc];
}

//TODO incomplete implementation warning.
-(void)bookDeleted
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
