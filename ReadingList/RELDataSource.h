#import <UIKit/UIKit.h>

@class ReadingList;
@class Book;

@interface RELDataSource : NSObject <UITableViewDataSource>

@property (readonly, nonatomic) ReadingList *readingList;

@property (readonly, nonatomic) NSString *storeName;

- (Book *)bookAtIndexPath:(NSIndexPath *)indexPath;

- (Book *)insertBookForDictionary:(NSDictionary *)bookInfo atIndexPath:(NSIndexPath *)indexPath;
- (void)insertBook:(Book *)book atIndexPath:(NSIndexPath *)indexPath;
- (void)removeBookAtIndexPath:(NSIndexPath *)indexPath;

- (void)save;

@end
