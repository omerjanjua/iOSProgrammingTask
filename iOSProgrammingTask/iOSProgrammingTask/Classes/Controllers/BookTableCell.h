//
//  BookTableCell.h
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 17/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookTableCell : UITableViewCell


//custom tablecell properties
@property (nonatomic, retain) IBOutlet UILabel *name;
@property (nonatomic, retain) IBOutlet UILabel *price;
@property (nonatomic, retain) IBOutlet UILabel *author;

@end
