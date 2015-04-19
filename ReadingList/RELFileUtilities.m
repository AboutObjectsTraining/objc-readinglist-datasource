//
//  RELFileUtilities.m
//  ReadingList
//
//  Created by Jonathan on 4/19/15.
//  Copyright (c) 2015 About Objects. All rights reserved.
//

#import "RELFileUtilities.h"


NSString *RELPathForDocument(NSString *name, NSString *type)
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [[paths.lastObject stringByAppendingPathComponent:name] stringByAppendingPathExtension:type];
}

