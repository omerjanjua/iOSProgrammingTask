//
//  BookViewController.m
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 14/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BookViewController.h"
#import "Book.h"
#import "BookTableCell.h"
#import "EditBookViewController.h"

@implementation BookViewController

@synthesize books = _books;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.books = [Book findAllSortedBy:@"name" ascending:YES];   
    [self setupNav];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma setupAdd

-(void) setupNav
{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBook:)];
    self.navigationItem.rightBarButtonItem = button;
    [button release];
    button = nil;
}

-(IBAction)addContact:(id)sender
{
    EditBookViewController *controller = [[EditBookViewController alloc] initWithNibName:@"EditBookView" bundle:nil];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.navigationController presentModalViewController:navController animated:YES];
    [controller release];
    controller = nil;
    [navController release]; 
    navController = nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.books count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BookCell";
    BookTableCell *cell = (BookTableCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (BookTableCell *) [[[NSBundle mainBundle] loadNibNamed:@"BookTableCell" owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Book *book = [self.books objectAtIndex:indexPath.row];
    cell.name.text = book.name;
    cell.author.text = book.authors;
    
    #warning TODO refactor this later on so you get the float/double value from nssnumber and convert that to string
    NSNumberFormatter *numberformatter = [[NSNumberFormatter alloc] init];
    [numberformatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *string = [[NSString alloc] initWithFormat:@"%@", [numberformatter stringFromNumber:book.price]];
    cell.price.text = string;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [super dealloc];
    self.books = nil;
}

@end
