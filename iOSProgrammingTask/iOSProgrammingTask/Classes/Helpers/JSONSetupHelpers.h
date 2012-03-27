//
//  JSONSetupHelpers.h
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 15/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONSetupHelpers : NSObject

+(BOOL)performFirstTimeSetup;
+(void)importInitialbooks;
+(void)importInitialauthors;
+(void)importInitialpublishers;

@end
