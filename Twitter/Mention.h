//
//  Mention.h
//  Twitter
//
//  Created by Kenny Chu on 2015/7/9.
//  Copyright (c) 2015年 Kenny Chu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Mention : NSObject
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) User *user;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)mentionsWithArray:(NSArray *)array;
@end
