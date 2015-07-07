//
//  TweetTableViewCell.m
//  Twitter
//
//  Created by Kenny Chu on 2015/7/1.
//  Copyright (c) 2015年 Kenny Chu. All rights reserved.
//

#import "TweetTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    [self.userProfileImg setImageWithURL:[NSURL URLWithString:self.tweet.user.profileImageUrl]];
    self.userName.text = tweet.user.name;
    self.screenName.text = [NSString stringWithFormat:@"@%@", tweet.user.screenname];
    self.createdAt.text = tweet.relativeTime;
    self.text.text = tweet.text;

}

- (IBAction)onReply:(id)sender {
    [self.delegate onClickReplyTweetTableViewCell:self];
}
- (IBAction)onRetweetBtn:(id)sender {
    [self.delegate onClickRetweetTweetTableViewCell:self];
}
- (IBAction)onFavoriteBtn:(id)sender {
    [self.delegate onClickFavoriteTweetTableViewCell:self];
}
@end
