#import <Foundation/Foundation.h>
#import "ModelObject.h"

extern const struct AuthorKeys {
    NSString * __unsafe_unretained firstName;
    NSString * __unsafe_unretained lastName;
} AuthorKeys;



@interface Author : ModelObject

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;

@property (nonatomic, readonly) NSString *fullName;

@end
