//
//  RFGradientView.m
//


#import "RFGradientView.h"

@interface RFGradientView()

@property (strong,nonatomic) CAGradientLayer *backgroundLayer;

@end

@implementation RFGradientView

-(void)drawRect:(CGRect)rect{
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSArray *gradientColors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:0.67 green:0.85 blue:0.84 alpha:1.0f ].CGColor, [UIColor colorWithRed:0.3 green:0.76 blue:0.75 alpha:1.0f].CGColor,nil];
    // [UIColor colorWithRed:0.07 green:0.28 blue:0.36 alpha:1.0f ].CGColor,
    CGFloat gradientLocations[] = {0, 1};
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) gradientColors, gradientLocations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);

}
@end
