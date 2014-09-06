//
//  constellationWindow.m
//  AstralCocos
//
//  Created by Timothy J on 5/09/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "constellationWindow.h"
#import "HelloWorldScene.h"
#import "IntroScene.h"

#import "CCBReader.h"

#ifdef __CC_PLATFORM_IOS
#import <UIKit/UIKit.h>
#else
#endif



// -----------------------------------------------------------------------
#pragma mark - constellationWindow
// -----------------------------------------------------------------------
@interface constellationWindow ()

@property CCDrawNode* line;

@property CCSprite* grid;
@property constellation *currentConstellation;
@property NSMutableDictionary * constellationBank;

@end

@implementation constellationWindow
{
    float divisions;
    float xGridTic;
    float yGridTic;
    CGPoint gridSize;
    
}

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------



/*
+ (constellationWindow *)scene
{
    return [[self alloc] init];
}
*/
// -----------------------------------------------------------------------

- (id)initWithSize:(CGSize)windowSize andDivisions:(int)divs
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    
    divisions = divs;
    xGridTic = windowSize.width / divisions;
    yGridTic = windowSize.height / divisions;
    gridSize = CGPointMake(windowSize.width,windowSize.height);
    
    NSLog(@" xgridtic =   %f   ygridtic =  %f  ",xGridTic,yGridTic);
    
    [self setAnchorPoint:ccp(0.5,0.5)];
    
    self.contentSize = CGSizeMake(windowSize.width + (xGridTic), windowSize.width + (yGridTic));
    //self.contentSizeType = CC
    self.userInteractionEnabled = YES;
    
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.3f green:0.3f blue:0.4f alpha:0.7f] width:self.contentSize.width height:self.contentSize.height];
    [self addChild:background];

    
    _constellationBank = [[NSMutableDictionary alloc]init];

    
    
    _line = [CCDrawNode node];
    [self addChild:_line];
    
    _grid = [CCSprite node];
    
    
    
    [self setupGrid:divisions];
    [self addChild:_grid];
    
    self.currentConstellation = [constellation node];
    [self.currentConstellation setSize:gridSize andDivisions:divs];
    [self addChild:_currentConstellation];
    [_currentConstellation setID:@"one"];

	return self;
}

- (void)update:(CCTime)delta{
    
}

// -----------------------------------------------------------------------

- (void)dealloc
{
    // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInteractionEnabled for the individual nodes
    // Per frame update is automatically enabled, if update is overridden
    self.userInteractionEnabled = true;
    
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}

// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

CGPoint oldpoint;
CCSprite * square;

NSTimeInterval j;

#ifdef __CC_PLATFORM_IOS
-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {

    CGPoint g = [touch locationInNode:self];
    [Utilities roundNumber:gx toNearest:xGridTic];
    [Utilities roundNumber:gy toNeaest:yGridTic];
    oldpoint = CGPointMake([Utilities roundNumber:g.x toNearest:xGridTic],[Utilities roundNumber:g.y toNearest:yGridTic]);
   /* if (oldpoint.x > 0 && oldpoint.y > 0 && oldpoint.y < self.scene.contentSize.height && oldpoint.x < self.scene.contentSize.height) */
    
        [_currentConstellation addStarAtX:oldpoint];
    
    //[self addChild:_constellation1]
    
    
    
    
}

-(void) touchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    
    
    
    // [_line clear];
    // [_line drawSegmentFrom:oldpoint to:[touch locationInNode:self] radius:3.0 color:[CCColor colorWithUIColor:[UIColor whiteColor]]];
    
    
    
    
    
}

- (void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event{

    
}

#else

- (void)mouseDown:(NSEvent *)theEvent
{
    CGPoint g = [theEvent locationInNode:self];
    
    oldpoint.x = [Utilities constrainInt:[Utilities roundNumber:g.x toNearest:xGridTic] betweenMinimum:xGridTic andMaximum:divisions * xGridTic];
    oldpoint.y = [Utilities constrainInt:[Utilities roundNumber:g.y toNearest:yGridTic] betweenMinimum:yGridTic andMaximum:divisions * yGridTic];
   // oldpoint = CGPointMake([Utilities roundNumber:g.x toNearest:xGridTic],[Utilities roundNumber:g.y toNearest:yGridTic]);
        [_currentConstellation addStarAtX:oldpoint];
    
}


- (void)mouseUp:(NSEvent *)theEvent
{
}

#endif



// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------
- (void)finishConstellation:(id)sender{
    
    [_currentConstellation finishConstellation];
    
    
}
- (void)onBackClicked:(id)sender
{
    
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionCrossFadeWithDuration: 0.5f]];
}

- (void)jupiter:(id)sender
{
    // back to intro scene with transition
    NSLog(@"Jupiter Pressed");
}

- (void)saturn:(id)sender
{
    // back to intro scene with transition
    NSLog(@"saturn Pressed");
}

- (void)ceres:(id)sender
{
    // back to intro scene with transition
    NSLog(@"ceres Pressed");
}

- (void)changeConstButton:(id)sender
{
    
    
    CCButton *g = (CCButton *)sender;
    // back to intro scene with transition
    NSLog(g.name);
    [self.currentConstellation setID:g.name];
}

// -----------------------------------------------------------------------

-(void)setupGrid:(int)div{
    
    
    CCColor *c = [CCColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    CCDrawNode * grild = [CCDrawNode node];
    
    
    
    for (int i = 1; i < divisions + 1; i++){
        
        CGPoint p1 =  CGPointMake(xGridTic, i * yGridTic);
        CGPoint p2 =  CGPointMake(gridSize.x, i * yGridTic);
        [grild drawSegmentFrom:p1 to:p2 radius:1 color:c];
        
        CGPoint p3 =  CGPointMake(i * xGridTic, yGridTic);
        CGPoint p4 =  CGPointMake(i * xGridTic, gridSize.y);
        [grild drawSegmentFrom:p3 to:p4 radius:1 color:c];
        
    }
    CCActionFadeTo *fadeIn = [CCActionFadeTo actionWithDuration:0.5 opacity:0.0];
    CCActionFadeTo *fadeOut = [CCActionFadeTo actionWithDuration:0.5 opacity:1.0];
    
    CCActionSequence *pulseSequence = [CCActionSequence actions:
                                       fadeIn, // I get a warning about incompatible pointer types...
                                       fadeOut,
                                       nil];
    [self runAction:[CCActionRepeatForever actionWithAction:pulseSequence]];
    [grild setAnchorPoint: ccp(0.5,0.5)];
    [grild setPosition:ccp(0.5,0.5)];
    [_grid setAnchorPoint:ccp(0.0,0.0)];
    [_grid addChild:grild];
    //[_grid setPosition:CGPointMake(xGridTic/2.0, yGridTic/2.0)];
    //_grid.shader = [CCShader shaderNamed:@"MotionBlur"];
}

-(void)constellationEnded{
    
    if ([_constellationBank objectForKey:[_currentConstellation getID]] != nil){
        [[_constellationBank objectForKey:[_currentConstellation getID]] removeFromParentAndCleanup:YES];
        [_constellationBank removeObjectForKey:[_currentConstellation getID]];
        
    }
    
    _constellationBank[[_currentConstellation getID]] = _currentConstellation;
    //[self addChild: _constellationBank[[_currentConstellation getID]]];
    
    //[_currentConstellation removeFromParentAndCleanup:YES];
    self.currentConstellation = [constellation node];
    [self.currentConstellation setSize:gridSize andDivisions:divisions];
    [self addChild:_currentConstellation];
    [_currentConstellation setID:@"two"];
    
}

-(float)getDivision{
    //return hei;
    return xGridTic;
}

@end



