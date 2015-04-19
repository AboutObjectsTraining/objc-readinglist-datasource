#import <Foundation/Foundation.h>
#import "ModelObject.h"

extern const struct BookKeys {
    NSString * __unsafe_unretained title;
    NSString * __unsafe_unretained year;
    NSString * __unsafe_unretained author;
} BookKeys;


@class Author;


@interface Book : ModelObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *year;

@property (nonatomic, retain) Author *author;

@end
