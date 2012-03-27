//
//  ReviewViewController.m
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 14/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ReviewViewController.h"
#import "Review.h"
#import "ReviewTableCell.h"
#import "IndividualReviewViewController.h"
#import "AddReviewViewController.h"

@implementation ReviewViewController

@synthesize review = _review;


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.review = [Review findAllSortedBy:@"title" ascending:YES];
    [self.tableView reloadData];
}

#pragma mark - setupAdd

-(void)setupNav
{
    UIBarButtonItem *button = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addReview:)]autorelease];
    self.navigationItem.rightBarButtonItem = button;
}

-(IBAction)addReview:(id)sender
{
    AddReviewViewController *controller = [[[AddReviewViewController alloc] initWithNibName:@"AddReviewView" bundle:nil] autorelease];
    controller.isModal = YES;
    UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController:controller] autorelease];
    [self.navigationController presentModalViewController:navController animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.review) {
        return [self.review count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ReviewCell";
    
    ReviewTableCell *cell = (ReviewTableCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (ReviewTableCell *) [[[NSBundle mainBundle] loadNibNamed:@"ReviewTableCell" owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Review *review = [self.review objectAtIndex:indexPath.row];
    

    cell.ratingLabel.text = [review.rating stringValue];
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
    IndividualReviewViewController *controller = [[[IndividualReviewViewController alloc] initWithNibName:@"IndividualReviewView" bundle:nil] autorelease];
    Review *review = [self.review objectAtIndex:indexPath.row];
    controller.review = review;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) dealloc
{
    self.review = nil;
    [super dealloc];
}

@end
