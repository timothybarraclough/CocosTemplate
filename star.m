//
//  star.m
//  Astral_Cocos3.0
//
//  Created by Timothy J on 1/09/14.
//  Copyright 2014 timothy j. All rights reserved.
//

#import "star.h"


@implementation star




-(id)initWithPosition:(CGPoint)pos{
    
    if (self = [super init]){
        
    
        [self drawDot:CGPointZero radius:4.0 color:[CCColor whiteColor]];
        self.position = pos;
    }

    return self;
    
}

-(void)setTimeForStar:(NSTimeInterval)t{
    
    timeTaken = t;
}

-(NSTimeInterval)getTimeForStar{
    
    return timeTaken;
}

-(void)explode{
    
    
    
    //CCActionRotateBy * b = [CCActionEaseInOut actionWithAction:[CCActionRotateBy actionWithDuration:0.5 angle:360.0] rate:3.0];
    CCActionSequence * b = [CCActionSequence actions:[CCActionEaseIn actionWithAction:[CCActionScaleTo actionWithDuration:0.15 scale:3.0] rate:3.0],[CCActionEaseOut actionWithAction:[CCActionScaleTo actionWithDuration:0.65 scale:1.0] rate:3.0], nil];
    [self runAction:b];
    /*
    CCParticleSystem *s = (CCParticleSystem *)[CCBReader load:@"explosion"];
    s.duration = 1.5;
    
    s.autoRemoveOnFinish = true;
    s.position = CGPointZero;
    [self addChild:s];
     */
    
    
    
    
    
}
    




@end
