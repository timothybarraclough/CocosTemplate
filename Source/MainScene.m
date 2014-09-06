//
//  MainScene.m
//  
//
//  Created by Timothy J on 4/09/14.
//
//

#import "MainScene.h"

@interface MainScene ()

@property CCDrawNode* line;

@property CCSprite* grid;
@property CCPhysicsNode *physicsWorld;
@property constellation *currentConstellation;
@property CCButton *button;
@property NSMutableDictionary * constellationBank;

@end



@implementation MainScene

{
    float divisions;
    float wid;
    float hei;
    
}

- (id)init
{
self = [super init];
if (!self) return(nil);



// Enable touch handling on scene node
self.userInteractionEnabled = YES;

// Create a colored background (Dark Grey)
CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.3f green:0.3f blue:0.4f alpha:1.0f]];
[self addChild:background];
// Create a back button
divisions = 18;
wid = self.scene.contentSize.height/divisions;
hei = self.scene.contentSize.height/divisions;


_constellationBank = [[NSMutableDictionary alloc]init];
_line = [CCDrawNode node];
[self addChild:_line];

_grid = [CCSprite node];



[self setupGrid:24];
[self addChild:_grid];
    [_grid setAnchorPoint:CGPointZero];
    [self setPosition:CGPointMake(80, 80)];
    [_grid setPosition:CGPointZero];

_currentConstellation = [constellation node];
[self addChild:_currentConstellation];
[_currentConstellation setID:@"one"];

    CCParticleSystem *g = (CCParticleSystem *)[CCBReader load:@"explosion"];
    //g.position = CGPointMake(self.scene.contentSize.width/2,self.scene.contentSize.height/2);
    [self addChild:g];
    
return self;
}

-(void)setupGrid:(int)div{

    CCColor *c = [CCColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    CCDrawNode * grild = [CCDrawNode node];
    for (int i = 1; i < divisions; i++){
        
        CGPoint p1 =  CGPointMake(hei, i * hei);
        CGPoint p2 =  CGPointMake(self.scene.contentSize.height - wid, i * hei);
        [grild drawSegmentFrom:p1 to:p2 radius:1 color:c];
        
        CGPoint p3 =  CGPointMake(i * wid, wid);
        CGPoint p4 =  CGPointMake(i * wid, self.scene.contentSize.height-wid);
        [grild drawSegmentFrom:p3 to:p4 radius:1 color:c];
        
    }
    /*
    CCActionFadeTo *fadeIn = [CCActionFadeTo actionWithDuration:0.5 opacity:0.0];
    CCActionFadeTo *fadeOut = [CCActionFadeTo actionWithDuration:0.5 opacity:1.0];
    
    CCActionSequence *pulseSequence = [CCActionSequence actions:
                                       fadeIn, // I get a warning about incompatible pointer types...
                                       fadeOut,
                                       nil];
    [self runAction:[CCActionRepeatForever actionWithAction:pulseSequence]];
     */
    [_grid addChild:grild];
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
    //CGPoint touchLoc = [touch locationInNode:self];
    
    // Log touch location
    /* oldpoint = [touch locationInNode:self];
     square =  [CCSprite spriteWithTexture:[CCTexture textureWithFile:@"saturn-1.png"]];
     [square setScaleX:30/square.contentSize.width];
     [square setScaleY:30/square.contentSize.width];
     
     
     square.position = oldpoint;
     [_physicsWorld addChild:square];
     */
    //j = event.timestamp;
    CGPoint g = [touch locationInNode:self];
    oldpoint = CGPointMake([Utilities roundNumber:g.x toNearest:wid],[Utilities roundNumber:g.y toNearest:wid]);
    if (oldpoint.x > 0 && oldpoint.y > 0 && oldpoint.y < self.scene.contentSize.height && oldpoint.x < self.scene.contentSize.height)
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
    oldpoint = CGPointMake([Utilities roundNumber:g.x toNearest:wid],[Utilities roundNumber:g.y toNearest:hei]);
    if (oldpoint.x > 0 && oldpoint.y > 0 && oldpoint.y < self.scene.contentSize.height && oldpoint.x < self.scene.contentSize.height)
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


-(void)saturn{
    
    NSLog(@"Saturn!");
}

-(void)jupiter{
    
    NSLog(@"Jupiter!");
}

-(void)ceres{
    
    NSLog(@"Ceres!");
}

-(void)pluto{
    
    NSLog(@"Pluto!");
}

@end
