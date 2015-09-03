//
//  RFMainTableViewCell.h
//  iTunesRSSFeed
//
//  Created by Manjusha on 8/21/15.
//  Copyright (c) 2015 Manjusha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RFMainTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleText;
@property (weak, nonatomic) IBOutlet UILabel *titleOfBook;
@property (weak, nonatomic) IBOutlet UILabel *authorText;
@property (weak, nonatomic) IBOutlet UIImageView *bookSIcon;
@property (weak, nonatomic)  UIView *gradientView;
@property (weak, nonatomic) IBOutlet UIView *gradientbg;

@end
