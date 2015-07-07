//
//  ActionTableViewCell.h
//  Twitter
//
//  Created by Kenny Chu on 2015/7/2.
//  Copyright (c) 2015年 Kenny Chu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ActionTableViewCell;

@protocol ActionTableViewCellDelegate <NSObject>

- (void)onClickReplyActionTableViewCell:(ActionTableViewCell *)cell;
- (void)onClickRetweetActionTableViewCell:(ActionTableViewCell *)cell;
- (void)onClickFavoriteActionTableViewCell:(ActionTableViewCell *)cell;
@end

@interface ActionTableViewCell : UITableViewCell
@property(nonatomic, weak)id<ActionTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *favoriteImg;
@property (weak, nonatomic) IBOutlet UIButton *retweetImg;
@end
