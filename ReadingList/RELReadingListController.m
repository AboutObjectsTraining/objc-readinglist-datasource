#import "RELReadingListController.h"
#import "RELViewBookController.h"
#import "RELAddBookController.h"
#import "RELDataSource.h"

#import "ReadingList.h"

@interface RELReadingListController ()

@property (readonly, nonatomic) RELDataSource *dataSource;
@property (readonly, nonatomic) NSIndexPath *insertionIndexPath;

@end


@implementation RELReadingListController

- (RELDataSource *)dataSource
{
    return (RELDataSource *) self.tableView.dataSource;
}


#pragma mark - Unwind Segues

- (IBAction)doneEditingBook:(UIStoryboardSegue *)segue {
    [self.dataSource save];
    [self.tableView reloadData];
}
- (IBAction)cancelEditingBook:(UIStoryboardSegue *)segue { }

- (IBAction)doneAddingBook:(UIStoryboardSegue *)segue {
    RELAddBookController *controller = segue.sourceViewController;
    [self addBookWithDictionary:controller.bookInfo];
}
- (IBAction)cancelAddingBook:(UIStoryboardSegue *)segue { }


#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.dataSource.readingList.title;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ViewBook"])
    {
        RELViewBookController *controller = segue.destinationViewController;
        controller.book = [self.dataSource bookAtIndexPath:self.tableView.indexPathForSelectedRow];
    }
}


#pragma mark - Adding New Books

// Extension point for customizing location of inserted book.
//
- (NSIndexPath *)insertionIndexPath
{
    return [NSIndexPath indexPathForRow:0 inSection:0];
}

- (void)addBookWithDictionary:(NSDictionary *)bookInfo
{
    [self.dataSource insertBookForDictionary:bookInfo atIndexPath:self.insertionIndexPath];
    [self.dataSource save];
    
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:self.insertionIndexPath
                          atScrollPosition:UITableViewScrollPositionNone
                                  animated:YES];
}


@end
