//
//  Twitter.h
//  Twitter
//
//  Created by Kenny Chu on 2015/6/29.
//  Copyright (c) 2015年 Kenny Chu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, assign) NSInteger tweetId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSString *createdAtStr;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *relativeTime;
@property (nonatomic, assign) NSInteger favorite_count;
@property (nonatomic, assign) NSInteger retweet_count;
@property (nonatomic, assign) BOOL favorited;
@property (nonatomic, assign) BOOL retweeted;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)tweetsWithArray:(NSArray *)array;

@end
