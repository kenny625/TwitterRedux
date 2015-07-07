//
//  TweetTableViewCell.h
//  Twitter
//
//  Created by Kenny Chu on 2015/7/1.
//  Copyright (c) 2015年 Kenny Chu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@class TweetTableViewCell;

@protocol TweetTableViewCellDelegate <NSObject>

- (void)onClickReplyTweetTableViewCell:(TweetTableViewCell*)cell;
- (void)onClickRetweetTweetTableViewCell:(TweetTableViewCell*)cell;
- (void)onClickFavoriteTweetTableViewCell:(TweetTableViewCell*)cell;

@end

@interface TweetTableViewCell : UITableViewCell
@property (weak, nonatomic) id<TweetTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImg;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *createdAt;
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (strong, nonatomic) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIButton *replyBtn;
@property (weak, nonatomic) IBOutlet UIButton *retweetBtn;
@property (weak, nonatomic) IBOutlet UIButton *favoriteBtn;

@end
