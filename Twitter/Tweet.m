//
//  Twitter.m
//  Twitter
//
//  Created by Kenny Chu on 2015/6/29.
//  Copyright (c) 2015年 Kenny Chu. All rights reserved.
//

#import "Tweet.h"
#import "NSDate+RelativeTime.h"

@implementation Tweet

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        NSLog(@"%@", dictionary);
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        self.text = dictionary[@"text"];
        NSString *createdAtString = dictionary[@"created_at"];
        self.createdAtStr = createdAtString;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        
        self.createdAt = [formatter dateFromString:createdAtString];
        self.relativeTime = [self.createdAt relativeTime];
        self.favorite_count = [[dictionary objectForKey:@"favorite_count"] integerValue];
        self.retweet_count = [[dictionary objectForKey:@"retweet_count"] integerValue];
        self.tweetId = [[dictionary objectForKey:@"id"] integerValue];
        self.favorited = ([[dictionary objectForKey:@"favorited"] integerValue] == 1) ? TRUE : FALSE;
        self.retweeted = ([[dictionary objectForKey:@"retweeted"] integerValue] == 1) ? TRUE : FALSE;
    }
    return self;
}

+ (NSArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [NSMutableArray array];
    
    for (NSDictionary *dictionary in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];
    }
    
    return tweets;
}

@end
