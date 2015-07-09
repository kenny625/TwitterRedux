//
//  MentionsViewController.m
//  Twitter
//
//  Created by Kenny Chu on 2015/7/8.
//  Copyright (c) 2015年 Kenny Chu. All rights reserved.
//

#import "MentionsViewController.h"
#import "TwitterClient.h"
#import "MentionTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface MentionsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray *mentions;
@end

@implementation MentionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    [self.tableview registerNib:[UINib nibWithNibName:@"MentionTableViewCell" bundle:nil] forCellReuseIdentifier:@"MentionCell"];
    
    
    [[TwitterClient sharedInstance] mentionsTimeLineWithParams:nil completion:^(NSArray *mentions, NSError *error) {
        self.mentions = mentions;
        [self.tableview reloadData];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mentions.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MentionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MentionCell"];
    Mention *mention = self.mentions[indexPath.row];
    cell.textLabel.text = mention.text;
    [cell.userImg setImageWithURL:[NSURL URLWithString:mention.user.profileImageUrl]];
    return cell;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
