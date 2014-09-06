//
//  constellation.m
//  Astral_Cocos3.0
//
//  Created by Timothy J on 1/09/14.
//  Copyright 2014 timothy j. All rights reserved.
//

#import "constellation.h"
#import "PdBase.h"
#import "CCBReader.h"
#import "math.h"
#import "HelloWorldScene.h"

@interface constellation ()

@property (nonatomic) NSString* constellationID;
@property (nonatomic) NSMutableArray * stars;
@property (nonatomic) NSMutableArray * times;
@property (nonatomic) CGPoint windowSize;
@property (nonatomic) float yTicSize;
@property (nonatomic) float xTicSize;
@property (nonatomic) int divisions;


@end

const float timeQuantize = 250.0;
NSInteger numberOfNotes = 7;
bool needsFinish = false;
//NSInteger notes[7];

@implementation constellation

- (void)setSize:(CGPoint)winSize andDivisions:(int)divsx{
    

    
    self.windowSize = winSize;
    self.divisions = divsx;
    self.yTicSize = winSize.y/self.divisions;
    self.xTicSize = winSize.x/self.divisions;
    //self.notes  = @[@40, @42, @44, @45, @47, @49, @51];
    //notes = {40,42,44,45,47,49,51};
    
}


 


-(void)beginTiming{
    
    
    timeOfLastStar = [Utilities roundNumber:CACurrentMediaTime() * 1000.0f toNearest:timeQuantize];


}

-(int)getMidiNoteNumber:(int)index{
    
    int notes[] = {60,61,63,65,68,69,71};
    
    int octave = floorf(12 * (index / numberOfNotes));
    
    return notes[index% numberOfNotes] + octave;
    
}

-(void)addStarAtX:(CGPoint)p{
    
    CGPoint pointIndex = CGPointMake(p.x / self.xTicSize, p.y / self.yTicSize);
    
    if (_stars == nil){

        line = [CCDrawNode node];
        
        [self addChild:line];
        _stars = [[NSMutableArray alloc]init];
        _times = [[NSMutableArray alloc]init];
       
        [self beginTiming];
        
    }
    
    else {
        
        star *first = (star *)[_stars objectAtIndex:0];
        
        if (CGPointEqualToPoint(first.position, p)){
            [self finishConstellation];
            return;
        }
        
        star *last = (star *)[_stars lastObject];
        [line boundingBox];
        [line drawSegmentFrom:last.position to:p radius:1.0 color:[CCColor whiteColor]];

    }

    star *s = [[star alloc ]initWithPosition:p];
    
    //[s setTexture:[CCSprite spriteWithTexture:[CCTexture textureWithFile:@"saturn-1.png"]]];
   // [s setScaleX:30/s.contentSize.width];
    //[s setScaleY:30/s.contentSize.width];
    
    [s setPosition:p];

    [self addChild:s];
    
    [PdBase sendFloat: [self getMidiNoteNumber:pointIndex.x] toReceiver:@"sball2"];
    [s explode];
    
    [s setTimeForStar:[Utilities roundNumber:(CACurrentMediaTime() * 1000.0f) - timeOfLastStar toNearest:timeQuantize]];
    [_stars addObject:s];
    [self beginTiming];
    NSLog(@"position = x  : %f",p.x);
    //NSLog(@"time since last star %f",s.getTimeForStar);


}

-(void)finishConstellation{
    
    
    star * e = [_stars objectAtIndex:([_stars count]-1)];
    star * s = [_stars objectAtIndex:0];
    
    [s setTimeForStar:[Utilities roundNumber:(CACurrentMediaTime() * 1000.0f) - timeOfLastStar toNearest:timeQuantize]];
    //[[stars firstObject]setTimeForStar:[Utilities timeStamp] - timeOfLastStar];
    NSLog(@"position = x  : %f",fmodf((CACurrentMediaTime() * 1000.0f), 500));
    [line drawSegmentFrom:e.position to:s.position radius:0.8 color:[CCColor grayColor]];
    needsFinish = true;
    [self performSelector:@selector(beginAnimating) withObject:nil afterDelay:(timeQuantize - fmodf((CACurrentMediaTime() * 1000.0f), timeQuantize))/1000.0f];
    
}

-(void)beginAnimating{
    

    
    
    CCDrawNode *j = [CCDrawNode node];
   
    [j drawDot:CGPointZero radius:4.0 color:[CCColor whiteColor]];
    

    
    
    
    
    star *s = (star *)[_stars objectAtIndex:0];
    j.position = s.position;
    targetStar = 1;
    NSMutableArray *actions = [[NSMutableArray alloc]initWithCapacity:(_stars.count) * 2];
    NSMutableArray *rotateActions = [[NSMutableArray alloc]initWithCapacity:(_stars.count) * 2];
    
    star * target = [_stars objectAtIndex:0];
    CCActionCallBlock * note = [CCActionCallBlock actionWithBlock:^{
        [PdBase sendFloat: [self getMidiNoteNumber:(target.position.x / self.xTicSize)] toReceiver:@"sball2"];
        [target explode];
        
        //NSLog(@"Contacted ball #  :  %lu",(unsigned long)0);
        
    }];
    [actions addObject:note];
    float angle = atan2(target.position.x - target.position.x,target.position.y - target.position.y) * (180/M_1_PI);
    // target.position.y - target2.position.y;
    
    CCActionRotateTo * r = [CCActionEaseIn actionWithAction:[CCActionRotateTo actionWithDuration:[target getTimeForStar]/1000.0 angle:angle] rate:3.0];
    [rotateActions addObject:r];
    
    for (NSUInteger i = 1; i < _stars.count; i++){
        
        star * target = [_stars objectAtIndex:i];
        
        star * target2 = [_stars objectAtIndex:(i+1)%_stars.count];
        
        CCActionMoveTo * move = [CCActionEaseInOut actionWithAction:[CCActionMoveTo actionWithDuration:[target getTimeForStar]/1000.0 position:target.position] rate:3.0];
        [actions addObject:move];
        //@selector (j) = [@selector(playNote) withObject:i];
        //CCActionCallFunc * note = [CCActionCallFunc actionWithTarget:self selector:@selector(playNote:)];
        CCActionCallBlock * note = [CCActionCallBlock actionWithBlock:^{
            [PdBase sendFloat: [self getMidiNoteNumber:(target.position.x / self.xTicSize)] toReceiver:@"sball2"];
            [target explode];
           // NSLog(@"Contacted ball #  :  %lu",(unsigned long)i);
            
        }];
        [actions addObject:note];
        
       float angle = atan2(target.position.x - target2.position.x,target.position.y - target2.position.y) * (180/M_1_PI);
       // target.position.y - target2.position.y;
        
        CCActionRotateTo * r = [CCActionEaseIn actionWithAction:[CCActionRotateTo actionWithDuration:[target getTimeForStar]/1000.0 angle:angle] rate:3.0];
        [rotateActions addObject:r];

    }
    

    // target.position.y - target2.position.y;
    
    CCActionMoveTo * move = [CCActionEaseInOut actionWithAction:[CCActionMoveTo actionWithDuration:[target getTimeForStar]/1000.0 position:target.position] rate:3.0];
    [actions addObject:move];
    //CCActionCallFunc * note = [CCActionCallFunc actionWithTarget:self selector:@selector(playNote)];
    [j runAction:[CCActionRepeatForever actionWithAction:[CCActionSequence actionWithArray:rotateActions]]];
    [j runAction:[CCActionRepeatForever actionWithAction:[CCActionSequence actionWithArray:actions]]];
    //[[self parent] addChild:j];
    [self addChild:j];
    [self.parent performSelector:@selector(constellationEnded)];
    
 
    
}

-(void)playNote:(id)sender{
    NSLog(@"sender");
    [PdBase sendBangToReceiver:@"ball"];
}




-(NSString *)getID{
    
    return _constellationID;
}

-(void)setID:(NSString *)myid{
    
    _constellationID = myid;
}

@end
