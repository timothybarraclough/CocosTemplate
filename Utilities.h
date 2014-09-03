//
//  Utilities.h
//  Astral_iOS
//
//  Created by Timothy J on 15/07/14.
//  Copyright (c) 2014 timothy barraclough. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject

+(float)roundNumber :(float) number toNearest:(float) round;
+(float)constrain :(float) number betweenMinimum:(float) min andMaximum:(float) max;
+(float)constrain :(float) number toMinimum:(float) min;
+(float)constrain :(float) number toMaximum:(float) max;
+(float)negMod : (float)dividend mod:(float)divisor;
+(int)constrainInt :(int) number betweenMinimum:(int) min andMaximum:(int) max;
//+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+(float) rwLength:(CGPoint) a;
+(CGPoint) rwSub:(CGPoint) a and:(CGPoint) b;
+ (NSTimeInterval) timeStamp ;
    

@end
