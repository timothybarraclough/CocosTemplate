//
//  HelloWorldScene.m
//  Astral_Cocos3.0
//
//  Created by Timothy J on 28/08/14.
//  Copyright timothy j 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "HelloWorldScene.h"
#import "IntroScene.h"
#import "CCBReader.h"

#ifdef __CC_PLATFORM_IOS
#import <UIKit/UIKit.h>
#else

//#import "Cocoa/Cocoa.h"
#endif



// -----------------------------------------------------------------------
#pragma mark - HelloWorldScene
// -----------------------------------------------------------------------


@implementation HelloWorldScene{
    
    CCPhysicsNode * physicsWorld;
    
    
    
}



// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (HelloWorldScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor greenColor] width:self.contentSize.width height:self.contentSize.height];
    
    [self addChild:background];
    
    CCButton *backButton = [CCButton buttonWithTitle:@"[  BACK  ]"];
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.9,0.9);
    [self addChild:backButton];
    
    
    physicsWorld = [CCPhysicsNode node];
    physicsWorld.gravity = ccp(0.0,0.0);
    [self addChild:physicsWorld];
    
    physicsWorld.debugDraw = true;
    
    CCDrawNode * walls = [CCDrawNode node];
    CGPoint touch = CGPointMake(self.contentSize.width, self.contentSize.height);
    CGPoint rect[] = {CGPointMake(0, touch.y),
        CGPointMake(touch.x, touch.y),
        CGPointMake(touch.x, 0),
        CGPointMake(0, 0)};
    [walls drawPolyWithVerts:rect count:4 fillColor:[CCColor clearColor] borderWidth:20.0 borderColor:[CCColor blackColor]];
    
    CCPhysicsBody *wallsBody = [CCPhysicsBody bodyWithPolylineFromRect:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height) cornerRadius:20];
    walls.physicsBody = wallsBody;
    
    [physicsWorld addChild:walls];
    
   
    
    	return self;
}

- (void)handleTouch:(CGPoint)touch{
    NSLog(@"Touch at x : %f y : %f",touch.x,touch.y);
    
    CCDrawNode * dot = [CCDrawNode node];
    CGPoint rect[] = {CGPointMake(touch.x - 10, touch.y - 10),
        CGPointMake(touch.x + 10, touch.y-10),
        CGPointMake(touch.x + 10, touch.y + 10),
        CGPointMake(touch.x - 10, touch.y + 10)};
    [dot drawPolyWithVerts:rect count:4 fillColor:[CCColor whiteColor] borderWidth:1 borderColor:[CCColor whiteColor]];
    
    CCPhysicsBody *rectBody  = [CCPhysicsBody bodyWithCircleOfRadius:12.0 andCenter:touch];
    rectBody.velocity = CGPointMake(20,30);
    dot.physicsBody = rectBody;
    
    [physicsWorld addChild:dot];
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
#ifdef __CC_PLATFORM_IOS
-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGPoint touchPoint = [touch locationInNode:self];
    [self handleTouch:touchPoint];
    
    
   }

-(void) touchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    

}

- (void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event{



}

#else

- (void)mouseDown:(NSEvent *)theEvent
{
    
    
    CGPoint touch = [theEvent locationInNode:self];
    [self handleTouch:touch];
    
    
    
    

    
}


- (void)mouseUp:(NSEvent *)theEvent
{
}

#endif



// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackClicked:(id)sender
{
    
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionCrossFadeWithDuration: 0.5f]];
}

// -----------------------------------------------------------------------


@end
