//
//  EntryData.m
//  iTunesRSSFeed
//
//  Created by Manjusha on 8/21/15.
//  Copyright (c) 2015 Manjusha. All rights reserved.
//

#import "EntryData.h"

@implementation EntryData

@synthesize summaryText, price, iTunesLinkUrl, title,category,iconLargeUrl,iconSmallUrl, imId , arrImageURLs ;

-(id) initWithDictionary: (NSDictionary *) aDictionary{
    self = [super init];
    if (self) {
        if (aDictionary && [aDictionary count] > 0) {
            //[self setSummaryText:[aDictionary valueForKey:@"summary.text"]];
            summaryText = [aDictionary valueForKeyPath:@"summary.text"];
            title =[aDictionary valueForKeyPath:@"title.text"];
            //[self setTitle:[aDictionary valueForKey:@"title.text"]];
            iTunesLinkUrl = [aDictionary valueForKeyPath:@"link.href"];
            arrImageURLs = [aDictionary valueForKey:@"im:image"];
            iconSmallUrl = [self getURLForSize:60];
            iconLargeUrl = [self getURLForSize:170];
            price = [aDictionary valueForKeyPath:@"im:price.text"];
            category = [aDictionary valueForKeyPath:@"category.label"];
        }
    }
    return self;
}

-(NSString*)getURLForSize:(int)size{
    NSString * url ;
    for (NSDictionary *item in arrImageURLs) {
        if ([[item valueForKey:@"height"]intValue]==size) {
            url = [item valueForKey:@"text"]  ;
        }
    }
    return url;
}
@end
