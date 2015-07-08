//
//  MainViewController.h
//  Twitter
//
//  Created by Kenny Chu on 2015/7/7.
//  Copyright (c) 2015年 Kenny Chu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuTableViewController.h"

@interface MainViewController : UIViewController
- (void)closeMenu;
@property (strong, nonatomic) LeftMenuTableViewController * leftMenuTableViewController;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;
@end
