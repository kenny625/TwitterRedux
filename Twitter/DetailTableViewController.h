//
//  DetailTableViewController.h
//  Twitter
//
//  Created by Kenny Chu on 2015/7/1.
//  Copyright (c) 2015年 Kenny Chu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface DetailTableViewController : UITableViewController
@property (strong, nonatomic) Tweet *tweet;
@end
