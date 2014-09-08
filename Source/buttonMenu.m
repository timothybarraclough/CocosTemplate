//
//  buttonMenu.m
//  AstralCocos
//
//  Created by Timothy J on 7/09/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "buttonMenu.h"




@implementation buttonMenu

{
    float hei;
    float wid;
    
}

- (id)initWithSize:(CGSize)windowSize and:(int)numOfButtons{
    
    
    self = [super init];
    if (!self) return(nil);
    
    [self setAnchorPoint:ccp(0.5,0.5)];
    
    
    
    self.contentSize = CGSizeMake(windowSize.width, windowSize.height);
    //self.contentSizeType = CC
    self.userInteractionEnabled = YES;
    
    //CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.3f green:0.7f blue:0.4f alpha:0.7f] width:self.contentSize.width height:self.contentSize.height];
    //[self addChild:background];
    
    hei = windowSize.height/numOfButtons;
    wid = windowSize.width;
    
    self.direction = CCLayoutBoxDirectionVertical;
    self.spacing = windowSize.height / (numOfButtons * 4);
    self.cascadeOpacityEnabled = YES;
    
    NSArray *sprites ={[NSArray arrayWithObjects:@"green.png",
        @"red.png",
        @"blue.png",
        @"orange.png",
        nil]};

    
    for (int i = 0; i < numOfButtons; i++){
        
      
            CCSpriteFrame *r1 = [CCSpriteFrame frameWithTexture:[CCTexture textureWithFile:[sprites objectAtIndex:i]] rectInPixels:CGRectMake(0,0,112,112) rotated:false offset:CGPointZero originalSize:CGSizeMake(112,112)];
        CCButton *x = [CCButton buttonWithTitle:@"" spriteFrame:r1];
        x.cascadeOpacityEnabled = x.cascadeColorEnabled = YES;
        x.contentSize = CGSizeMake(wid, wid);
        //HelloWorldScene *h = (HelloWorldScene *)self.parent;
        //x.name = [h.constellationNames objectAtIndex:i];
        x.name = [[HelloWorldScene constellationNames] objectAtIndex:i];
        
       // NSLog([h.constellationNames objectAtIndex:i]);
        
        [x setTarget:self selector:@selector(changeConstButton:)];
        [self addChild:x];
    }
    
   // self.
    
    self.opacity = 0.0f;
    [self runAction:[CCActionFadeIn actionWithDuration:2.0f]];
    
    /*
    for (int i = 0; i < 1; i++){
        CCSpriteFrame *r3 = [CCSpriteFrame frameWithImageNamed:@"green.png"];
        
    CCSpriteFrame *r1 = [CCSpriteFrame frameWithTexture:[CCTexture textureWithFile:@"red.png"] rectInPixels:CGRectMake(0,0,wid,hei) rotated:false offset:CGPointZero originalSize:CGSizeMake(112, 112)];
    CCSpriteFrame *r2 = [CCSpriteFrame frameWithTexture:[CCTexture textureWithFile:@"redSel.png"] rectInPixels:CGRectMake(0,0,wid,hei) rotated:false offset:CGPointZero originalSize:CGSizeMake(112, 112)];
    CCButton *red = [CCButton buttonWithTitle:@"" spriteFrame:r1 highlightedSpriteFrame:r2 disabledSpriteFrame:r2];
        red.positionType = CCPositionTypeNormalized;
    [red setPosition:ccp(0.5,.25)];
        [red setAnchorPoint:ccp(0.5,0.5)];
        red.contentSize = CGSizeMake(wid, hei);
    //[red setTarget:self selector:@selector(changeConstButton:)];
    [red setName:@"pluto"];
    [self addChild:red];
    }
     */
    
	return self;
}

- (void)changeConstButton:(id)sender
{
    
    
    CCButton *g = (CCButton *)sender;
    NSLog(g.name);
    // back to intro scene with transition
    [(HelloWorldScene *)self.parent changeConstButton:(id)sender];
    //[self.currentConstellation setID:g.name];
}

@end
