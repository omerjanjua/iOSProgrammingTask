//
//  AppDelegate.m
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 14/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "BookViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    [MagicalRecordHelpers setupCoreDataStack];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

-(void) applicationWillTerminate:(UIApplication *)application
{
    [MagicalRecordHelpers cleanUp];
}

- (void)dealloc
{
    self.window = nil;
    self.tabBarController = nil;
    [super dealloc];
}

@end
