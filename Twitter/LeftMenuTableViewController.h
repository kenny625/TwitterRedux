//
//  LeftMenuTableViewController.h
//  Twitter
//
//  Created by Kenny Chu on 2015/7/6.
//  Copyright (c) 2015年 Kenny Chu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftMenuTableViewControllerDelegate <NSObject>
- (void)clickMenuItemAtIndex:(NSInteger)index;
@end

@interface LeftMenuTableViewController : UITableViewController
+ (LeftMenuTableViewController *)sharedInstance;
@property (weak, nonatomic) id<LeftMenuTableViewControllerDelegate> delegate;
@end
