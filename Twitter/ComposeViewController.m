//
//  ComposeViewController.m
//  Twitter
//
//  Created by Kenny Chu on 2015/7/2.
//  Copyright (c) 2015年 Kenny Chu. All rights reserved.
//

#import "ComposeViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"

@interface ComposeViewController ()

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel)];
    if (self.isNewTweet) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweet)];
    } else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Reply" style:UIBarButtonItemStylePlain target:self action:@selector(onTweet)];
    }
    
    [self.userImg setImageWithURL:[NSURL URLWithString:self.userImgUrl]];
    self.name.text = self.nameStr;
    self.screenName.text = self.screenNameStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onTweet {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[NSString stringWithFormat:@"%ld", self.tweetId] forKey:@"in_reply_to_status_id"];
    [params setValue:self.textField.text forKey:@"status"];
    if (self.isNewTweet) {
        
    } else {
        [[TwitterClient sharedInstance] replyWithParams:params completion:^(NSArray *response, NSError *error) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
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
