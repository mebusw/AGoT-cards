//
//  AppDelegate.h
//  agot-ios
//
//  Created by mebusw on 12-2-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) FMDatabase *db;
@property (nonatomic, retain) IBOutlet UINavigationController *userNav;

@end
