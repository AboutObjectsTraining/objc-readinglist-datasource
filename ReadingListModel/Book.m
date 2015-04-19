#import "Book.h"
#import "Author.h"

#import "NSString+RELAdditions.h"

const struct BookKeys BookKeys = {
    .title = @"title",
    .year = @"year",
    .author = @"author",
};

@implementation Book

@synthesize title = _title;
@synthesize year = _year;
@synthesize author = _author;

+ (NSArray *)keys
{
    static NSArray *_keys;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _keys = @[BookKeys.title, BookKeys.year, BookKeys.author];
    });
    return _keys;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableVals = [[super dictionaryWithValuesForKeys:self.class.keys] mutableCopy];
    
    Author *author = [mutableVals objectForKey:@"author"];

    [mutableVals setObject:[author dictionaryRepresentation]
                    forKey:@"author"];
    
    return mutableVals;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
//    if ([key isEqualToString:@"author"] &&
    
    if ([key matchesPropertyName:@"author"] &&
        [value isKindOfClass:[NSDictionary class]])
    {
        value = [Author modelObjectWithDictionary:value];
    }
    
    [super setValue:value forKey:key];
}

- (NSString *)description
{
    return [NSString stringWithFormat:
            @"Title: %@, Year: %@, Author: %@",
            [self title],
            [self year],
            [self author]];
}

@end









