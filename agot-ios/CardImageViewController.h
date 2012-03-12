//
//  CardImageViewController.h
//  agot-ios
//
//  Created by mebusw on 12-3-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardImageViewController : UIViewController

@property (nonatomic, assign) int pageId;
@property (nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) NSString *imageName;

@end
