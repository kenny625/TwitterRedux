//
//  ProfileViewController.m
//  Twitter
//
//  Created by Kenny Chu on 2015/7/7.
//  Copyright (c) 2015年 Kenny Chu. All rights reserved.
//

#import "ProfileViewController.h"
#import "MentionsViewController.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.userProfileImg setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];
    [self.userBackgroundImg setImageWithURL:[NSURL URLWithString:self.user.profileBackgroundImageUrl]];
    self.userBackgroundImg.contentMode = UIViewContentModeScaleAspectFill;
    self.userBackgroundImg.clipsToBounds = YES;
    self.name.text = self.user.name;
    self.screenName.text = [NSString stringWithFormat:@"@%@", self.user.screenname] ;
    self.tweetsCount.text = [NSString stringWithFormat:@"tweets\n\t%@", self.user.statusCount];
    self.followingCount.text = [NSString stringWithFormat:@"following\n\t%@", self.user.followingCount];
    self.followerscount.text = [NSString stringWithFormat:@"followers\n\t%@", self.user.followersCount];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
