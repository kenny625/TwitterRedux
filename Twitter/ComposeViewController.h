//
//  ComposeViewController.h
//  Twitter
//
//  Created by Kenny Chu on 2015/7/2.
//  Copyright (c) 2015年 Kenny Chu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) NSString *userImgUrl;
@property (strong, nonatomic) NSString *nameStr;
@property (strong, nonatomic) NSString *screenNameStr;
@property (assign, nonatomic) NSInteger tweetId;
@property (assign, nonatomic) BOOL isNewTweet;

@end
