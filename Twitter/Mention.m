//
//  Mention.m
//  Twitter
//
//  Created by Kenny Chu on 2015/7/9.
//  Copyright (c) 2015年 Kenny Chu. All rights reserved.
//

#import "Mention.h"

@implementation Mention
- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        //        NSLog(@"mentions %@", dictionary);
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        self.text = dictionary[@"text"];
    }
    return self;
}

+ (NSArray *)mentionsWithArray:(NSArray *)array {
    NSMutableArray *mentions = [NSMutableArray array];
    
    for (NSDictionary *dictionary in array) {
        [mentions addObject:[[Mention alloc] initWithDictionary:dictionary]];
    }
    
    return mentions;
}
@end
