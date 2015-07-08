//
//  TweetsViewController.h
//  Twitter
//
//  Created by Kenny Chu on 2015/6/30.
//  Copyright (c) 2015年 Kenny Chu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuTableViewController.h"
#import "MainViewController.h"
#import "ProfileViewController.h"
#import "MentionsViewController.h"

@interface TweetsViewController : UIViewController
@property (strong, nonatomic) LeftMenuTableViewController * leftMenuTableViewController;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;
@property (strong, nonatomic) ProfileViewController *profileViewController;
@property (strong, nonatomic)MentionsViewController * mentionsViewController;
@property (strong, nonatomic) UINavigationController *profileViewControllerNav;
@property (strong, nonatomic) UINavigationController *mentionsViewControllerNav;
@end
