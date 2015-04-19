//
//  NSString+RELAdditions.m
//  ReadingList
//
//  Created by Jonathan on 4/19/15.
//  Copyright (c) 2015 About Objects. All rights reserved.
//

#import "NSString+RELAdditions.h"

@implementation NSString (RELAdditions)

- (BOOL)matchesPropertyName:(NSString *)propertyName
{
    return ([self isEqualToString:propertyName] ||
            [self isEqualToString:[NSString stringWithFormat:@"_%@", propertyName]]);
}

@end
