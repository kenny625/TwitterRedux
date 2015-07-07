//
//  TwitterClient.m
//  Twitter
//
//  Created by Kenny Chu on 2015/6/29.
//  Copyright (c) 2015年 Kenny Chu. All rights reserved.
//

#import "TwitterClient.h"
#import "Tweet.h"

NSString * const kTwitterConsumerKey = @"uGBez86TgiwR6WYxxj8VQSdkZ";
NSString * const kTwitterConsumerSecret= @"wJOTXIySdQ914PxfGRY1ulbNmUdTuCnXMem1H7Yfo6CFIkkSTl";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

@interface TwitterClient()

@property (nonatomic, strong) void (^loginCompletion)(User *user, NSError *error);

@end

@implementation TwitterClient

+ (TwitterClient *)sharedInstance {
    static TwitterClient *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[[TwitterClient alloc] init] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
        }
    });
    return instance;
}

-(void)loginWithCompletion:(void (^)(User *user, NSError *error))completion {
    self.loginCompletion = completion;
    
    [self.requestSerializer removeAccessToken];
    [[TwitterClient sharedInstance] fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"twitterhw://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        NSLog(@"Got request token");
        NSURL *authURL = [NSURL URLWithString: [NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authURL];
        
    } failure:^(NSError *error) {
        NSLog(@"Failed to get request token");
        self.loginCompletion(nil, error);
    }];
}

- (void)openURL:(NSURL *)url {
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken) {
        NSLog(@"Got the access token");
        [self.requestSerializer saveAccessToken:accessToken];
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            User *user = [[User alloc] initWithDictionary:responseObject];
            self.loginCompletion(user, nil);
            [User setCurrentUser:user];
            NSLog(@"current user %@", user.name);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Fail to get current user");
            self.loginCompletion(nil, error);
        }];
        
    } failure:^(NSError *error) {
        NSLog(@"Fail to get the access token");
        self.loginCompletion(nil, error);
    }];
}

- (void)homeTimeLineWithParams:(NSDictionary*) parrams completion:(void (^)(NSArray *tweets, NSError *error))completion {
    [self GET:@"1.1/statuses/home_timeline.json" parameters:parrams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

- (void)replyWithParams:(NSDictionary*) params completion:(void (^)(NSArray *response, NSError *error))completion {
    [self POST:@"1.1/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

- (void)retweetWithId:(NSInteger) tweetid completion:(void (^)(NSArray *response, NSError *error))completion {
    [self POST:[NSString stringWithFormat:@"1.1/statuses/retweet/%ld.json", tweetid] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

- (void)favoriteWithId:(NSInteger) tweetid completion:(void (^)(NSArray *response, NSError *error))completion {
    [self POST:[NSString stringWithFormat:@"1.1/favorites/create.json?id=%ld", tweetid]    parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

//- (void)newTweetWithParams:(NSDictionary*) params completion:(void (^)(NSArray *response, NSError *error))completion {
//    [self POST:@"1.1/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        completion(responseObject, nil);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        completion(nil, error);
//    }];
//}

@end
