//
//  NSString+HTML.h
//

#import <Foundation/Foundation.h>


@interface NSString (HTML)

+ (NSString*) decodeHtmlUnicodeCharactersToString:(NSString*)str;

@end