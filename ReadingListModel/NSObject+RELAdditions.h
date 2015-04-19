//
//  NSObject+RELAdditions.h
//  ReadingList
//
//  Created by Jonathan on 4/19/15.
//  Copyright (c) 2015 About Objects. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (RELAdditions)

- (void)setValue:(id)value forPrefixedKey:(NSString *)key;
- (void)setValuesForPrefixedKeysWithDictionary:(NSDictionary *)keyedValues;

@end
