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
#import "Additions.h"
#import "IterationHelper.h"


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
    
    NSMutableString *authorString = [NSMutableString string];
    NSArray *authorArray = [self.book.authors allObjects];
    for (Author *author in authorArray) {
        [authorString appendFormat:@"%@, %@", author.surname, author.firstName];
    }
    self.authorValue.text = authorString;
    
    
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
    

    self.priceValue.text = [self.book.price stringValue];
    
}

-(void)setupInitialBookValues
{
    self.book.name = @"";

    NSMutableString *authorString = [NSMutableString string];
    NSArray *authorArray = [self.book.authors allObjects];
    for (Author *author in authorArray) {
        [authorString stringByAppendingFormat:@""];
    }
    self.authorValue.text = authorString;
    
    
    NSMutableString *publisherString = [NSMutableString string];
    NSArray *publisherArray = [self.book.publishers allObjects];
    for (Publisher *publisher in publisherArray) {
        [publisherString stringByAppendingFormat:@""];;
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

-(void)dealloc
{
    self.book = nil;
    [super dealloc];
}


//to remove incomplete implementation warning.
-(void)bookDeleted
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
