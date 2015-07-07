//
//  ActionTableViewCell.m
//  Twitter
//
//  Created by Kenny Chu on 2015/7/2.
//  Copyright (c) 2015年 Kenny Chu. All rights reserved.
//

#import "ActionTableViewCell.h"
#import "TwitterClient.h"

@implementation ActionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)onReply:(id)sender {
    [self.delegate onClickReplyActionTableViewCell:self];
}
- (IBAction)onRetweet:(id)sender {
    [self.delegate onClickRetweetActionTableViewCell:self];
}
- (IBAction)onFavorite:(id)sender {
    [self.delegate onClickFavoriteActionTableViewCell:self];
}

@end
