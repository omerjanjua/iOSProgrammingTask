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
-(void)setupBooks;
-(void)setupInitialBookValues;
-(void)setupNav;

@end

@implementation IndividualBookViewController
@synthesize scrollView = _scrollView;
@synthesize contentView = _contentView;
@synthesize nameValue = _nameValue;
@synthesize priceValue = _priceValue;
@synthesize releaseValue = _releaseValue;
@synthesize authorValue = _authorValue;
@synthesize publisherValue = _publisherValue;
@synthesize reviewValue = _reviewValue;
@synthesize book = _book;

#pragma mark - setupView

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
    self.scrollView.contentSize = self.contentView.frame.size;
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupBooks];
}

#pragma mark - edit

-(void)setupNav
{
    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
    UIBarButtonItem *button = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed:)]autorelease];
    self.navigationItem.rightBarButtonItem = button;
}

#pragma mark - editButtonPressed
-(IBAction)editButtonPressed:(id)sender
{
    EditBookViewController *controller = [[[EditBookViewController alloc] initWithNibName:@"EditBookView" bundle:nil]autorelease];
    controller.book = self.book;
    controller.deleteDelegate = self;
    controller.isModal = YES;
    
    UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController:controller]autorelease];
    [self.navigationController presentModalViewController:navController animated:YES];
}

#pragma mark - setupBooks
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

#pragma mark - unload outlets

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.scrollView = nil;
    self.contentView = nil;
    self.nameValue = nil;
    self.priceValue = nil;
    self.releaseValue = nil;
    self.authorValue = nil;
    self.publisherValue = nil;
    self.reviewValue = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


//to remove incomplete implementation warning.
-(void)bookDeleted
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
