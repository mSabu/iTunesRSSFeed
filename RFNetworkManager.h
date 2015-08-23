//
//  RFNetworkManager.h
//  iTunesRSSFeed
//
//  Created by Manjusha on 8/21/15.
//  Copyright (c) 2015 Manjusha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RFNetworkManager : NSObject

+(void)beginDownloadTask:(NSString*)urlString withCompletionHandler:(void (^)(NSDictionary *operations, NSError *error))completionBlock;
+(void)getImageFromURL:(NSString*)urlString withCompletionHandler:(void (^)(NSData *responseData, NSError *error))completionBlock;
@end
