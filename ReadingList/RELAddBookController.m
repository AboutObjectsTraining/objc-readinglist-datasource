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

@property (strong, readwrite, nonatomic) Book *book;

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *yearField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;

@end


@implementation RELAddBookController

- (void)transferValues
{
    NSDictionary *dict = @{ BookKeys.title: self.titleField.text,
                            BookKeys.year: self.yearField.text,
                            BookKeys.author: @{ AuthorKeys.firstName: self.firstNameField.text,
                                                AuthorKeys.lastName: self.lastNameField.text }};
    
    self.completionBlock(dict);
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Done"]) {
        [self transferValues];
    }

    // Breaks potential retain cycle.
    //
    self.completionBlock = nil;
}


@end
