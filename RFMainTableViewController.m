//
//  RFMainTableViewController.m
//  iTunesRSSFeed
//
//  Created by Manjusha on 8/21/15.
//  Copyright (c) 2015 Manjusha. All rights reserved.
//

#import "RFMainTableViewController.h"
#import "RFHelper.h"
#import "RFMainTableViewCell.h"
#import "RFNetworkManager.h"
#import "EntryData.h"
#import "RFDetailViewController.h"


@interface RFMainTableViewController (){
    
    
    NSDictionary *urlsFromPlist;
    __block NSMutableArray  *arrEntryData;
    int selectedRow;
        UIImageOrientation scrollOrientation;
        CGPoint lastPos;
    

}

@end

@implementation RFMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    urlsFromPlist =  [RFHelper getUrlsFromBundlePlist];
    
    arrEntryData = [NSMutableArray array];
    [self getDataFromURL];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl = refreshControl;
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged ];

}
-(void)getDataFromURL{
    int rand = arc4random_uniform(4);
    NSString * key = [urlsFromPlist allKeys][rand];
    NSString * url = [urlsFromPlist valueForKey:key];
    self.navigationItem.title = key;
    
    __weak __typeof(self)weakSelf = self;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [RFNetworkManager beginDownloadTask:url withCompletionHandler:^(id respObject, NSError *error){
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^(){
                [weakSelf showErrorAlert:error.localizedDescription];
            });
        } else {
            [weakSelf updateTableWithData:respObject];
            dispatch_async(dispatch_get_main_queue(), ^(){
                [weakSelf.tableView reloadData];
            }); }
    }];

}
-(void)updateTableWithData:(NSDictionary*)response{
    [self.refreshControl endRefreshing];
    NSArray *arrEntries =  [RFHelper getEntriesFromResponse:response];
    [(arrEntries[0]) enumerateObjectsUsingBlock:^(NSDictionary * entry, NSUInteger idx, BOOL *stop) {
        HelperInstance.entryData = [[EntryData alloc]initWithDictionary:entry];
        [arrEntryData addObject:HelperInstance.entryData];
    }];
}

-(void)refreshData{
    [arrEntryData removeAllObjects];
    [self getDataFromURL];
}

#pragma mark - Error Alert 
-(void)showErrorAlert:(NSString*)errMessage{
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:kEmpty message:errMessage delegate:self cancelButtonTitle:kOk otherButtonTitles:nil, nil];
    [errorAlert show];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return arrEntryData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = kCellIdentifier;
    
    RFMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:kMainTableViewCell owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    if (arrEntryData != nil && arrEntryData.count > 0) {
        [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleSingleLineEtched];
        
        EntryData *en = [arrEntryData objectAtIndex:indexPath.row];
        cell.titleOfBook.text = [en.title substringToIndex:[en.title rangeOfString:kSeperator].location];

        cell.authorText.text =[en.title substringFromIndex:[en.title rangeOfString:kSeperator].location + 2 ];
        cell.bookSIcon.image = kLoadingImage;
        [RFNetworkManager getImageFromURL:en.iconSmallUrl withCompletionHandler:^(NSData *responseData, NSError *error) {
            UIImage *downloadedImage = [UIImage imageWithData:responseData];
            dispatch_async(dispatch_get_main_queue(), ^{
                   cell.bookSIcon.image = downloadedImage;
            });
        }];
    }    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedRow = (int)indexPath.row ;
    
    [self performSegueWithIdentifier:kDetailView sender:self];

}
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.isDragging) {
        UIView *myView = cell.contentView;
        CALayer *layer = myView.layer;
        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
        rotationAndPerspectiveTransform.m34 = 1.0 / -1000;
        if (scrollOrientation == UIImageOrientationDown) {
            rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, M_PI*0.5, 1.0f, 0.0f, 0.0f);
        } else {
            rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, -M_PI*0.5, 1.0f, 0.0f, 0.0f);
        }
        layer.transform = rotationAndPerspectiveTransform;
        [UIView animateWithDuration:0.5 animations:^{
            layer.transform = CATransform3DIdentity;
        }];
    }
}
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    scrollOrientation = scrollView.contentOffset.y > lastPos.y?UIImageOrientationDown:UIImageOrientationUp;
    lastPos = scrollView.contentOffset;
}
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kDetailView]) {
        RFDetailViewController *controller = (RFDetailViewController*)segue.destinationViewController;
        controller.entryDetails = arrEntryData[selectedRow];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
