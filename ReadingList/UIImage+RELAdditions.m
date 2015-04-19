//
//  UIImage+RELAdditions.m
//  ReadingList
//
//  Created by Jonathan on 4/19/15.
//  Copyright (c) 2015 About Objects. All rights reserved.
//

#import "UIImage+RELAdditions.h"

@implementation UIImage (RELAdditions)

+ (UIImage *)rel_imageNamed:(NSString *)name
{
    UIImage *image = [self imageNamed:name];
    
    return image ? image : [self imageNamed:@"DefaultImage"];
}

@end
