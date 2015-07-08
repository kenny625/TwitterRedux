//
//  MainViewController.m
//  Twitter
//
//  Created by Kenny Chu on 2015/7/7.
//  Copyright (c) 2015年 Kenny Chu. All rights reserved.
//

#import "MainViewController.h"
#import "MenuTableViewCell.h"

@interface MainViewController () <UIGestureRecognizerDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.leftMenuTableViewController = [[LeftMenuTableViewController alloc] init];
    
    [self addChildViewController:self.leftMenuTableViewController];
    [self.view addSubview:self.leftMenuTableViewController.view];
    [self.leftMenuTableViewController didMoveToParentViewController:self];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGestureRecognizer:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    self.tapGestureRecognizer =
    [[UITapGestureRecognizer alloc]
     initWithTarget:self
     action:@selector(onTap)];
    
    self.tapGestureRecognizer.delegate = self;
    
    NSLog(@"didload");
    
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"willappear");
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    NSLog(@"superview %@", touch.view.superview);
    if ([touch.view.superview isKindOfClass:[MenuTableViewCell class]]) {
        return FALSE;
    } else {
       return TRUE;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
