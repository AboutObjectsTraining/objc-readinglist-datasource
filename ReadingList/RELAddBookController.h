//
//  RELAddBookController.h
//  ReadingList
//
//  Created by Jonathan on 4/19/15.
//  Copyright (c) 2015 About Objects. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Book;

@interface RELAddBookController : UITableViewController

@property (readonly, nonatomic) Book *book;
@property (strong, nonatomic) void (^completionBlock)(NSDictionary *bookDict);

@end
