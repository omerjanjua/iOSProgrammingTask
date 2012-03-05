//
//  ReviewTableCell.m
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 02/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ReviewTableCell.h"

@implementation ReviewTableCell
@synthesize titleLabel = _titleLabel;
@synthesize ratingLabel = _ratingLabel;

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

- (void)dealloc {
    self.titleLabel = nil;
    self.ratingLabel = nil;
    [super dealloc];
}
@end
