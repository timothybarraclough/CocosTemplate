//
//  constellation.h
//  Astral_Cocos3.0
//
//  Created by Timothy J on 1/09/14.
//  Copyright 2014 timothy j. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Utilities.h"
#import "star.h"

@interface constellation : CCNode {
    

    NSTimeInterval timeOfLastStar;
    
    CCDrawNode * line;
    int targetStar;
    
    
    
    
    
    
    
}

-(void)beginTiming;

-(void)addStarAtX:(CGPoint)position;

-(void)finishConstellation;

-(NSString *)getID;

-(void)setID:(NSString *)myID;



@end