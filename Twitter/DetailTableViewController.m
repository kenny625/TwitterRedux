//
//  DetailTableViewController.m
//  Twitter
//
//  Created by Kenny Chu on 2015/7/1.
//  Copyright (c) 2015年 Kenny Chu. All rights reserved.
//

#import "DetailTableViewController.h"
#import "DetailTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "StatisticsTableViewCell.h"
#import "ActionTableViewCell.h"
#import "ComposeViewController.h"
#import "User.h"
#import "TwitterClient.h"

@interface DetailTableViewController () <UITableViewDelegate, UITableViewDataSource, ActionTableViewCellDelegate>

@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"DetailCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"StatisticsTableViewCell" bundle:nil] forCellReuseIdentifier:@"StatisticsCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ActionTableViewCell" bundle:nil] forCellReuseIdentifier:@"ActionCell"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    switch (indexPath.row) {
        case 0:
            {
                DetailTableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
                detailCell.name.text = self.tweet.user.name;
                detailCell.screenName.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenname];
                [detailCell.userImg setImageWithURL:[NSURL URLWithString:self.tweet.user.profileImageUrl]];
                detailCell.text.text = self.tweet.text;
                detailCell.time.text = self.tweet.createdAtStr;
                cell = detailCell;
            }
            break;
        case 1:
            {
                StatisticsTableViewCell *statisticsCell = [tableView dequeueReusableCellWithIdentifier:@"StatisticsCell" forIndexPath:indexPath];
                statisticsCell.retweet_count.text = [NSString stringWithFormat:@"%ld", (long)self.tweet.retweet_count];
                statisticsCell.favorite_count.text = [NSString stringWithFormat:@"%ld", (long)self.tweet.favorite_count];
                cell = statisticsCell;
            }
            break;
        case 2:
            {
                ActionTableViewCell *actionCell = [tableView dequeueReusableCellWithIdentifier:@"ActionCell" forIndexPath:indexPath];
                actionCell.delegate = self;
                if (self.tweet.favorited) {
                    UIImage *image = [UIImage imageNamed: @"favorite_on.png"];
                    [actionCell.favoriteImg setImage:image forState:UIControlStateNormal];
                }
                if (self.tweet.retweeted) {
                    UIImage *image = [UIImage imageNamed: @"retweet_on.png"];
                    [actionCell.retweetImg setImage:image forState:UIControlStateNormal];
                }
                cell = actionCell;
            }
            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (void)onClickReplyActionTableViewCell:(ActionTableViewCell *)cell {
    ComposeViewController *composeViewController = [[ComposeViewController alloc] initWithNibName:@"ComposeViewController" bundle:nil];
    User *user = [User currentUser];
    composeViewController.nameStr = user.name;
    composeViewController.screenNameStr = user.screenname;
    composeViewController.userImgUrl = user.profileImageUrl;
    composeViewController.tweetId = self.tweet.tweetId;
    composeViewController.isNewTweet = FALSE;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:composeViewController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)onClickRetweetActionTableViewCell:(ActionTableViewCell *)cell {
    [[TwitterClient sharedInstance] retweetWithId:self.tweet.tweetId completion:^(NSArray *response, NSError *error) {
        [[TwitterClient sharedInstance] homeTimeLineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
            self.tweet.retweet_count = self.tweet.retweet_count + 1;
            self.tweet.retweeted = TRUE;
            [self.tableView reloadData];
        }];
    }];
}

- (void)onClickFavoriteActionTableViewCell:(ActionTableViewCell *)cell {
    [[TwitterClient sharedInstance] favoriteWithId:self.tweet.tweetId completion:^(NSArray *response, NSError *error) {
        self.tweet.favorite_count = self.tweet.favorite_count + 1;
        self.tweet.favorited = TRUE;
        [self.tableView reloadData];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
