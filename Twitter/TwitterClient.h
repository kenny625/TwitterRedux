//
//  TwitterClient.h
//  Twitter
//
//  Created by Kenny Chu on 2015/6/29.
//  Copyright (c) 2015年 Kenny Chu. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager
+ (TwitterClient *)sharedInstance;

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;
- (void)openURL:(NSURL *)url;

- (void)homeTimeLineWithParams:(NSDictionary*) parrams completion:(void (^)(NSArray *tweets, NSError *error))completion;
- (void)replyWithParams:(NSDictionary*) params completion:(void (^)(NSArray *response, NSError *error))completion;
- (void)retweetWithId:(NSInteger) tweetid completion:(void (^)(NSArray *response, NSError *error))completion;
- (void)favoriteWithId:(NSInteger) tweetid completion:(void (^)(NSArray *response, NSError *error))completion;
@end
