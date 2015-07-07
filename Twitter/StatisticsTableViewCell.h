//
//  StatisticsTableViewCell.h
//  Twitter
//
//  Created by Kenny Chu on 2015/7/2.
//  Copyright (c) 2015年 Kenny Chu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatisticsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *retweet_count;
@property (weak, nonatomic) IBOutlet UILabel *favorite_count;

@end
