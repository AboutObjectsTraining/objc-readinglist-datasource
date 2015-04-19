#import "RELDataSource.h"
#import "RELFileUtilities.h"
#import "UIImage+RELAdditions.h"

#import "ReadingList.h"
#import "Book.h"
#import "Author.h"


@interface RELDataSource ()

@property (copy, readwrite, nonatomic) NSString *title;
@property (strong, nonatomic) NSMutableArray *books;
@property (readonly, nonatomic) NSString *storePath;

@end


@implementation RELDataSource

#pragma mark - Creating and Initializing

- (instancetype)init
{
    if (!(self = [super init])) return nil;
    
    ReadingList *readingList = [self readingList];
    _title = [readingList.title copy];
    _books = [readingList.books mutableCopy];
    
    return self;
}


#pragma mark - File-based Persistence

- (NSString *)storeName { return @"BooksAndAuthors"; }
- (NSString *)storePath { return RELPathForDocument(self.storeName, @"plist"); }

- (ReadingList *)readingList
{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:self.storePath];
    
    if (dict == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:self.storeName ofType:@"plist"];
        dict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    
    return [ReadingList modelObjectWithDictionary:dict];
}

- (void)save
{
    ReadingList *newReadingList = [[ReadingList alloc] init];
    newReadingList.title = self.title;
    newReadingList.books = self.books;
    
    [newReadingList.dictionaryRepresentation writeToFile:self.storePath atomically:YES];
}


#pragma mark - Managing the Books Array

- (Book *)bookAtIndexPath:(NSIndexPath *)indexPath
{
    return self.books[indexPath.row];
}

- (Book *)insertBookForDictionary:(NSDictionary *)bookInfo atIndexPath:(NSIndexPath *)indexPath
{
    Book *book = [Book modelObjectWithDictionary:bookInfo];
    [self insertBook:book atIndexPath:indexPath];
    
    return book;
}

- (void)insertBook:(Book *)book atIndexPath:(NSIndexPath *)indexPath
{
    [self.books insertObject:book atIndex:indexPath.row];
}

- (void)removeBookAtIndexPath:(NSIndexPath *)indexPath
{
    [self.books removeObjectAtIndex:indexPath.row];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.books.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookSummary"];
    
    Book *book = self.books[indexPath.row];
    
    cell.textLabel.text = book.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", book.year, book.author.fullName];
    cell.imageView.image = [UIImage rel_imageNamed:book.author.lastName];
    
    return cell;
}

// Handling for insertion and deletion triggered from the UI.
//
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (editingStyle)
    {
        case UITableViewCellEditingStyleDelete:
            [self removeBookAtIndexPath:indexPath];
            [self save];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case UITableViewCellEditingStyleInsert:
            // Can be triggered via a row displaying a '+' icon.
            break;
        default:
            break;
    }
}


@end
