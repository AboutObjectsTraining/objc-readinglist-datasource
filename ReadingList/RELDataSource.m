#import "RELDataSource.h"
#import "RELFileUtilities.h"
#import "UIImage+RELAdditions.h"

#import "ReadingList.h"
#import "Book.h"
#import "Author.h"


@interface RELDataSource ()

@property (strong, readwrite, nonatomic) ReadingList *readingList;
@property (strong, nonatomic) NSMutableArray *books;

@property (readonly, nonatomic) NSString *storePath;

@end


@implementation RELDataSource

#pragma mark - File-based Persistence

- (NSString *)storeName { return @"BooksAndAuthors"; }
- (NSString *)storePath { return RELPathForDocument(self.storeName, @"plist"); }

/// Returns a mutable proxy for the reading list's books array.
//
- (NSMutableArray *)books
{
    return [self.readingList mutableArrayValueForKey:@"books"];
}

- (ReadingList *)readingList
{
    if (_readingList == nil)
    {
        [self loadReadingList];
    }
    
    return _readingList;
}

- (void)loadReadingList
{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:self.storePath];
    
    if (dict == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:self.storeName ofType:@"plist"];
        dict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    
    self.readingList = [ReadingList modelObjectWithDictionary:dict];
}

- (void)save
{
    [self.readingList.dictionaryRepresentation writeToFile:self.storePath atomically:YES];
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
