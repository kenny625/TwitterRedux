//
//  TweetsViewController.m
//  Twitter
//
//  Created by Kenny Chu on 2015/6/30.
//  Copyright (c) 2015年 Kenny Chu. All rights reserved.
//

#import "TweetsViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "TweetTableViewCell.h"
#import "DetailTableViewController.h"
#import "ComposeViewController.h"

@interface TweetsViewController () <UITableViewDelegate, UITableViewDataSource, TweetTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSArray *tweets;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    [self.tableview registerNib:[UINib nibWithNibName:@"TweetTableViewCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    
    self.navigationItem.title = @"Home";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(onLogout)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(onNewTweet)];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.24 green:0.78 blue:0.96 alpha:0.5];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBarHidden = NO;
    // Do any additional setup after loading the view from its nib.
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(refreshData)
                  forControlEvents:UIControlEventValueChanged];
    [self.tableview addSubview:self.refreshControl];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGestureRecognizer:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    
        
    self.leftMenuTableViewController = [[LeftMenuTableViewController alloc] init];
    
    [self addChildViewController:self.leftMenuTableViewController];
    [self.view addSubview:self.leftMenuTableViewController.view];
    [self.leftMenuTableViewController didMoveToParentViewController:self];
    
    self.tapGestureRecognizer =
    [[UITapGestureRecognizer alloc]
     initWithTarget:self
     action:@selector(onTap)];
    
}
- (void)onTap {
    [self closeMenu];
}

- (void)moveViewWithGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint velocity = [panGestureRecognizer velocityInView:self.view];
    if (velocity.x > 50) {
        [self revealMenu];
    }
    
    if (velocity.x < -50) {
        [self closeMenu];
    }
}

- (void)revealMenu {
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.leftMenuTableViewController.view.frame = CGRectMake(0.0f, 64.0f, [[UIScreen mainScreen] bounds].size.width * 0.4f, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                    
                     }];
}

- (void)closeMenu {
    [self.view removeGestureRecognizer:self.tapGestureRecognizer];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.leftMenuTableViewController.view.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width * (-0.4f), 64.0f, [[UIScreen mainScreen] bounds].size.width * 0.4f, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                        
                     }];
}

- (void)refreshData {
    [[TwitterClient sharedInstance] homeTimeLineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        if (error != nil) {
            NSLog(@"Timeline error %@", error);
        }
        self.tweets = tweets;
        [self.tableview reloadData];
        [self.refreshControl endRefreshing];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [[TwitterClient sharedInstance] homeTimeLineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        if (error != nil) {
            NSLog(@"Timeline error %@", error);
        }
        self.tweets = tweets;
        [self.tableview reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    cell.delegate = self;
    cell.tweet = self.tweets[indexPath.row];
    if (cell.tweet.favorited) {
        UIImage *image = [UIImage imageNamed: @"favorite_on.png"];
        [cell.favoriteBtn setImage:image forState:UIControlStateNormal];
    }
    if (cell.tweet.retweeted) {
        UIImage *image = [UIImage imageNamed: @"retweet_on.png"];
        [cell.retweetBtn setImage:image forState:UIControlStateNormal];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailTableViewController *detailTableViewController = [[DetailTableViewController alloc] initWithNibName:@"DetailTableViewController" bundle:nil];
    detailTableViewController.navigationItem.title = @"Tweet";
    detailTableViewController.tweet = self.tweets[indexPath.row];
    [self.navigationController pushViewController:detailTableViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onLogout {
    [User logout];
}

- (void)onNewTweet {
    ComposeViewController *composeViewController = [[ComposeViewController alloc] initWithNibName:@"ComposeViewController" bundle:nil];
    User *user = [User currentUser];
    composeViewController.nameStr = user.name;
    composeViewController.screenNameStr = user.screenname;
    composeViewController.userImgUrl = user.profileImageUrl;
    composeViewController.isNewTweet = TRUE;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:composeViewController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)onClickReplyTweetTableViewCell:(TweetTableViewCell *)cell {
    ComposeViewController *composeViewController = [[ComposeViewController alloc] initWithNibName:@"ComposeViewController" bundle:nil];
    User *user = [User currentUser];
    composeViewController.nameStr = user.name;
    composeViewController.screenNameStr = user.screenname;
    composeViewController.userImgUrl = user.profileImageUrl;
    Tweet *tweet = self.tweets[[self.tableview indexPathForCell:cell].row];
    composeViewController.tweetId = tweet.tweetId;
    composeViewController.isNewTweet = FALSE;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:composeViewController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)onClickRetweetTweetTableViewCell:(TweetTableViewCell *)cell {
    Tweet *tweet = self.tweets[[self.tableview indexPathForCell:cell].row];
    [[TwitterClient sharedInstance] retweetWithId:tweet.tweetId completion:^(NSArray *response, NSError *error) {
        UIImage *image = [UIImage imageNamed: @"retweet_on.png"];
        [cell.retweetBtn setImage:image forState:UIControlStateNormal];
        [[TwitterClient sharedInstance] homeTimeLineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
            if (error != nil) {
                NSLog(@"Timeline error %@", error);
            }
            self.tweets = tweets;
            [self.tableview reloadData];
        }];
    }];
}

- (void)onClickFavoriteTweetTableViewCell:(TweetTableViewCell *)cell {
    Tweet *tweet = self.tweets[[self.tableview indexPathForCell:cell].row];
    [[TwitterClient sharedInstance] favoriteWithId:tweet.tweetId completion:^(NSArray *response, NSError *error) {
        UIImage *image = [UIImage imageNamed: @"favorite_on.png"];
        [cell.favoriteBtn setImage:image forState:UIControlStateNormal];
        [[TwitterClient sharedInstance] homeTimeLineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
            if (error != nil) {
                NSLog(@"Timeline error %@", error);
            }
            self.tweets = tweets;
            [self.tableview reloadData];
        }];
    }];
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
