//
//  RFNetworkManager.m
//  iTunesRSSFeed
//
//  Created by Manjusha on 8/21/15.
//  Copyright (c) 2015 Manjusha. All rights reserved.
//

#import "RFNetworkManager.h"
#import "RFHelper.h"
#import "Reachability.h"
#import "RFAppDelegate.h"

@implementation RFNetworkManager

+(void)beginDownloadTask:(NSString *)urlString withCompletionHandler:(void (^)(NSDictionary *, NSError *))completionBlock{
    if (!([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)) {
        
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                              dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

                                                  if ([response respondsToSelector:@selector(statusCode)]) {
                                                      if ([(NSHTTPURLResponse *) response statusCode] == 200) {
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              if (data && data != nil && (data != (id)[NSNull null])) {
                                                                  NSDictionary * dict = [RFHelper xmlToDictionaryConversion:data];
                                                                  completionBlock(dict, nil);
                                                                  return;
                                                              }
                                                          });
                                                      }
                                                  }else {
                                                      completionBlock(nil, error);
                                                  }
                                              }];
        [downloadTask setTaskDescription:@"contentDownload"];
        [downloadTask resume];
    }
    else {
        completionBlock(nil,[RFHelper getError:kNoInternet]);
    }
}
+(void)getImageFromURL:(NSString*)urlString withCompletionHandler:(void (^)(NSData *responseData, NSError *error))completionBlock{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionDataTask *imageDwnldTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                              if (error) {
                                                  completionBlock(nil, error);
                                                  return;
                                              }
                                              if ([(NSHTTPURLResponse *) response statusCode] == 200) {
                                                          completionBlock(data, nil);
                                                          return;
                                                  }
                                          }];
    [imageDwnldTask setTaskDescription:@"imageDownload"];
    [imageDwnldTask resume];
}

@end
