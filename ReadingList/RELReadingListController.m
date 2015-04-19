#import "RELReadingListController.h"
#import "RELViewBookController.h"
#import "RELAddBookController.h"
#import "RELDataSource.h"

@interface RELReadingListController ()

//@property (strong, nonatomic) IBOutlet RELDataSource *dataSource;
@property (readonly, nonatomic) RELDataSource *dataSource;
@property (readonly, nonatomic) NSIndexPath *insertionIndexPath;

@end


@implementation RELReadingListController

- (RELDataSource *)dataSource
{
    return (RELDataSource *) self.tableView.dataSource;
}


#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddBook"])
    {
        UINavigationController *navController = segue.destinationViewController;
        RELAddBookController *controller = navController.childViewControllers.firstObject;
        
        controller.completionBlock = ^(NSDictionary *bookInfo) {
            [self addBookWithDictionary:bookInfo];
        };
    }
    else
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


#pragma mark - Unwind Segues

- (IBAction)doneEditingBook:(UIStoryboardSegue *)segue {
    // Save data source and refresh table view
    [self.dataSource save];
    [self.tableView reloadData];
}
- (IBAction)cancelEditingBook:(UIStoryboardSegue *)segue { }

- (IBAction)doneAddingBook:(UIStoryboardSegue *)segue { }
- (IBAction)cancelAddingBook:(UIStoryboardSegue *)segue { }

@end
