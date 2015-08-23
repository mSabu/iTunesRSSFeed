//
//  RFHelper.m
//  iTunesRSSFeed
//
//  Created by Manjusha on 8/21/15.
//  Copyright (c) 2015 Manjusha. All rights reserved.
//

#import "RFHelper.h"
#import "RFXMLReader.h"

@implementation RFHelper
@synthesize arrOfFeedEntries;

+(RFHelper *)sharedInstance
{
    static id sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[self alloc] init];     
    });
    return sharedObject;
}

+(NSDictionary*)getUrlsFromBundlePlist{
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",kRFplist,kPlist]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        plistPath = [[NSBundle mainBundle] pathForResource:kRFplist ofType:kPlist];
    }
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    return dict;
}

+(NSDictionary*)xmlToDictionaryConversion:(NSData*)xmlData {
    NSError *parseError = nil;
    
    NSDictionary *xmlDictionary = [RFXMLReader dictionaryForXMLData:xmlData error:&parseError];
    
    return xmlDictionary;
}
+(NSArray*)getEntriesFromResponse:(NSDictionary *)response{
    
    NSMutableArray *arrEntries = [NSMutableArray array];
    [arrEntries addObject:[response valueForKeyPath:kEntryKey]];
    return arrEntries;
}
+(NSError*)getError:(NSString*)errMessage{
    NSError * customError = nil;
    customError = [NSError errorWithDomain:kErrorDomain code:100 userInfo:@{NSLocalizedDescriptionKey:errMessage}];
    return customError;
}
@end
