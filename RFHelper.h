//
//  RFHelper.h
//  iTunesRSSFeed
//
//  Created by Manjusha on 8/21/15.
//  Copyright (c) 2015 Manjusha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntryData.h"
#import "RFConstants.h"
#import "RFGradientView.h"

#define HelperInstance [RFHelper sharedInstance]

@interface RFHelper : NSObject

@property (strong,nonatomic) EntryData *entryData;
@property (strong,nonatomic) NSMutableArray * arrOfFeedEntries;

+(RFHelper *)sharedInstance;


+(NSDictionary*)getUrlsFromBundlePlist;

+(NSDictionary*)xmlToDictionaryConversion:(NSData*)xmlData;
+(NSArray*)getEntriesFromResponse:(NSDictionary *)response;
+(NSError*)getError:(NSString*)errMessage;


@end
