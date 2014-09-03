//
//  Utilities.m
//  Astral_iOS
//
//  Created by Timothy J on 15/07/14.
//  Copyright (c) 2014 timothy barraclough. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+(float)roundNumber :(float) number toNearest:(float) round{
    if(fmodf(number, round) <= (round / 2.0))
    return number - fmodf(number, round);   //Round down
    else return number - fmodf(number, round) + round;   //Round down, then up again
}

+(float)constrain :(float) number toMaximum:(float) max{
return (number > max) ? max : number;
}

+(float)constrain :(float) number toMinimum:(float) min{
    return (number < min) ? min : number;
}

+(float)constrain :(float) number betweenMinimum:(float) min andMaximum:(float) max{
    float temp = (number < min) ? min : number;
    return (temp > max) ? max : temp;
}

/*
 static inline CGPoint rwAdd(CGPoint a, CGPoint b) {
 return CGPointMake(a.x + b.x, a.y + b.y);
 }
 */
+(CGPoint) rwSub:(CGPoint) a and:(CGPoint) b{
    return CGPointMake(a.x - b.x, a.y - b.y);
}
/*
 static inline CGVector rwMult(CGVector a, float b) {
 
 return CGVectorMake(a.dx * b, a.dy * b);
 }
 */
+(float) rwLength:(CGPoint) a {
    return sqrtf(a.x * a.x + a.y * a.y);
}

+(int)constrainInt :(int) number betweenMinimum:(int) min andMaximum:(int) max{
    int temp = (number < min) ? min : number;
    return (temp > max) ? max : temp;
}

+(float)negMod : (float)dividend mod:(float)divisor{
    if (dividend >= divisor) return dividend-divisor;
    if (dividend < 0) return divisor+dividend;
    return dividend;
}
/*
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
 */

+ (NSTimeInterval) timeStamp {
    return [[NSDate date] timeIntervalSince1970] * 1000;
}


@end
