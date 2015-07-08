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

@interface TweetsViewController : MainViewController
@property (strong, nonatomic) LeftMenuTableViewController * leftMenuTableViewController;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;
@end
