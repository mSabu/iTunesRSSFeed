//
//  NSString+HTML.m
//

#import "NSString+HTML.h"

@implementation NSString (HTML)

+ (NSString*) decodeHtmlUnicodeCharactersToString:(NSString*)string
{
    
        string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
        string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
        string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
        
        return string;
    
}

@end