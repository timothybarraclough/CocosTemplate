//
//  star.h
//  Astral_Cocos3.0
//
//  Created by Timothy J on 1/09/14.
//  Copyright 2014 timothy j. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCBReader.h"

@interface star :  CCDrawNode {
    
    NSTimeInterval timeTaken;
    
    //-(id)initWithPosition:(CGPoint)pos;

}


-(void)setTimeForStar:(NSTimeInterval)t;
-(NSTimeInterval)getTimeForStar;
-(id)initWithPosition:(CGPoint)position;
-(void)explode;



@end
