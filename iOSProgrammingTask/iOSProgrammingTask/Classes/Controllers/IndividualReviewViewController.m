//
//  IndividualReviewViewController.m
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 02/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IndividualReviewViewController.h"

@interface IndividualReviewViewController ()
-(void)setupNav;
-(void)setupReview;
-(void)setupInitialReviewValvues;

@end

@implementation IndividualReviewViewController
@synthesize titleLabel = _titleLabel;
@synthesize ratingLabel = _ratingLabel;
@synthesize commentsTextview = _commentsTextview;
@synthesize review = _review;

#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupReview];
}

#pragma mark - setupNav
-(void)setupNav
{
    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
}

#pragma mark - setupReview
-(void)setupReview
{
    if (!self.review) {
        Review *review = [Review createEntity];
        self.review = review;
        [self setupInitialReviewValvues];
    }
    self.titleLabel.text = self.review.title;
    self.commentsTextview.text = self.review.comment;
    
    NSNumberFormatter *numberformatter = [[NSNumberFormatter alloc] init];
    [numberformatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *string = [[NSString alloc] initWithFormat:@"%@", [numberformatter stringFromNumber:self.review.rating]];
    self.ratingLabel.text = string;
}

-(void)setupInitialReviewValvues
{
    self.review.title = @"";
    self.review.comment = @"";
    
    NSNumberFormatter *numberformatter = [[NSNumberFormatter alloc] init];
    [numberformatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *string = [[[NSString alloc] initWithFormat:@"%@", [numberformatter stringFromNumber:self.review.rating]]autorelease];
    string = @"";
}

#pragma mark - unLoad
- (void)viewDidUnload
{
    [super viewDidUnload];
    self.titleLabel = nil;
    self.ratingLabel = nil;
    self.commentsTextview = nil;    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
