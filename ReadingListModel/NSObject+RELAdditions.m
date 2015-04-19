//
//  NSObject+RELAdditions.m
//  ReadingList
//
//  Created by Jonathan on 4/19/15.
//  Copyright (c) 2015 About Objects. All rights reserved.
//

#import "NSObject+RELAdditions.h"

@implementation NSObject (RELAdditions)

- (void)setValue:(id)value forPrefixedKey:(NSString *)key
{
    [self setValue:value forKey:[NSString stringWithFormat:@"_%@", key]];
}

- (void)setValuesForPrefixedKeysWithDictionary:(NSDictionary *)keyedValues
{
    for (NSString *key in keyedValues) {
        [self setValue:keyedValues[key] forPrefixedKey:key];
    }
}

@end
