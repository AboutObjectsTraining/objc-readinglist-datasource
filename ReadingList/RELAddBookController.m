//
//  RELAddBookController.m
//  ReadingList
//
//  Created by Jonathan on 4/19/15.
//  Copyright (c) 2015 About Objects. All rights reserved.
//

#import "RELAddBookController.h"
#import "Book.h"
#import "Author.h"

@interface RELAddBookController ()

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *yearField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;

@end


@implementation RELAddBookController

- (NSDictionary *)bookInfo
{
    return @{ BookKeys.title: self.titleField.text,
              BookKeys.year: self.yearField.text,
              BookKeys.author: @{ AuthorKeys.firstName: self.firstNameField.text,
                                  AuthorKeys.lastName: self.lastNameField.text }};
}

@end
