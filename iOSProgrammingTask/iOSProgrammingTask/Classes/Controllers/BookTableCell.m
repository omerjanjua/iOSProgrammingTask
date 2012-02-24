//
//  BookTableCell.m
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 17/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BookTableCell.h"

@implementation BookTableCell

@synthesize name = _name;
@synthesize price = _price;
@synthesize author = _author;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) dealloc
{
    self.name = nil;
    self.price = nil;
    self.author = nil;
    [super dealloc];
}

@end
