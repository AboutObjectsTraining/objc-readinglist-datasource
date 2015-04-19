#import <UIKit/UIKit.h>

@class Book;

@interface RELDataSource : NSObject <UITableViewDataSource>

@property (readonly, nonatomic) NSString *storeName;
//@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (copy, readonly, nonatomic) NSString *title;
//@property (readonly, nonatomic) NSArray *books;

- (Book *)bookAtIndexPath:(NSIndexPath *)indexPath;

- (Book *)insertBookForDictionary:(NSDictionary *)bookInfo atIndexPath:(NSIndexPath *)indexPath;
- (void)insertBook:(Book *)book atIndexPath:(NSIndexPath *)indexPath;
- (void)removeBookAtIndexPath:(NSIndexPath *)indexPath;

- (void)save;

@end
