//
//  RFDetailViewController.m
//  iTunesRSSFeed
//
//  Created by Manjusha on 8/21/15.
//  Copyright (c) 2015 Manjusha. All rights reserved.
//

#import "RFDetailViewController.h"
#import "RFNetworkManager.h"
#import "NSString+HTML.h"

@interface RFDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;
@property (weak, nonatomic) IBOutlet UILabel *bookTitle;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *viewIniBooks;
@property (weak, nonatomic) IBOutlet UITextView *summaryTextView;
@property (weak, nonatomic) IBOutlet UILabel *category;
- (IBAction)openiBooks:(id)sender;
@property (weak, nonatomic) IBOutlet RFGradientView *gradientView;

@end

@implementation RFDetailViewController
@synthesize entryDetails, bookTitle, category, imageIcon,viewIniBooks, author, price, summaryTextView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    bookTitle.text = [entryDetails.title substringToIndex:[entryDetails.title rangeOfString:kSeperator].location];
    
   // [bookTitle setPreferredMaxLayout:200.0];
    
    price.text = [entryDetails.price uppercaseString];
    NSString * decodedString = [NSString decodeHtmlUnicodeCharactersToString:entryDetails.summaryText];
    summaryTextView.text = decodedString ;
    
    category.text = entryDetails.category;
    [summaryTextView scrollRangeToVisible:NSMakeRange(0, 1)];
    [summaryTextView setFont:kTextFont];
    [summaryTextView setTextAlignment:NSTextAlignmentJustified];
   
    
    viewIniBooks.layer.borderColor = [UIColor whiteColor].CGColor;
    viewIniBooks.layer.borderWidth = 1.0f;
    viewIniBooks.layer.cornerRadius = 5.0f;
    imageIcon.image = kLoadingImage;
    author.text = [entryDetails.title substringFromIndex:[entryDetails.title rangeOfString:kSeperator].location+2];
    
    //NSString *url =  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? entryDetails.iconLargeUrl : entryDetails.iconSmallUrl;
    self.gradientView.layer.cornerRadius = CORNER_RADIUS;
    self.gradientView.layer.masksToBounds = YES;
    [RFNetworkManager getImageFromURL:entryDetails.iconLargeUrl withCompletionHandler:^(NSData *responseData, NSError *error) {
        UIImage *downloadedImage = [UIImage imageWithData:responseData];
        dispatch_async(dispatch_get_main_queue(), ^{
            imageIcon.image = downloadedImage;
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openiBooks:(id)sender {    
    NSString *stringURL = [NSString stringWithFormat:@"%@%@",kiBooksLink,[entryDetails.iTunesLinkUrl substringFromIndex:6]];
    
    NSURL *url = [NSURL URLWithString:stringURL];
    
    [[UIApplication sharedApplication] openURL:url];
}


@end
