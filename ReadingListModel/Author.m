#import "Author.h"

const struct AuthorKeys AuthorKeys = {
    .firstName = @"firstName",
    .lastName = @"lastName",
};


@implementation Author

+ (NSArray *)keys
{
    static NSArray *_keys;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _keys = @[AuthorKeys.firstName, AuthorKeys.lastName];
    });
    return _keys;
}

- (NSString *)fullName
{
    return [NSString stringWithFormat:@"%@, %@", [self lastName], [self firstName]];
}

- (NSString *)description
{
    return [self fullName];
}

@end
