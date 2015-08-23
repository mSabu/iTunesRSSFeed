//
//  EntryData.h
//  iTunesRSSFeed
//
//  Created by Manjusha on 8/21/15.
//  Copyright (c) 2015 Manjusha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EntryData : NSObject


@property (nonatomic, strong) NSString * summaryText;
@property (nonatomic, strong) NSString * price;
@property (nonatomic, strong) NSString * iTunesLinkUrl;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * iconSmallUrl;
@property (nonatomic, strong) NSString * iconLargeUrl;
@property (nonatomic, strong) NSString * imId;
@property (nonatomic, strong) NSArray * arrImageURLs;

-(id) initWithDictionary: (NSDictionary *) aDictionary;


@end
