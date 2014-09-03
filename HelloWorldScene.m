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
@interface HelloWorldScene ()

@property CCDrawNode* line;

@property CCSprite* grid;
@property CCPhysicsNode *physicsWorld;
@property constellation *currentConstellation;
@property CCButton *button;
@property NSMutableDictionary * constellationBank;

@end

@implementation HelloWorldScene
{
    float divisions;
    float wid;
    float hei;
    
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
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.3f green:0.3f blue:0.4f alpha:1.0f]];
    [self addChild:background];
    // Create a back button
    divisions = 18;
    wid = self.scene.contentSize.height/divisions;
    hei = self.scene.contentSize.height/divisions;
    NSLog(@"WIDTH NUMBER  %f",wid);
    
    _constellationBank = [[NSMutableDictionary alloc]init];
    
    
    
    /*
    _button = [CCButton buttonWithTitle:@"finish" fontName:@"Verdana-Bold" fontSize:100.0f];
    _button.positionType = CCPositionTypeNormalized;
    _button.position = ccp(0.75f, 0.5f);
    [_button setTarget:self selector:@selector(finishConstellation:)];
    
    [self addChild:_button];
    */
    CCButton *backButton = [CCButton buttonWithTitle:@"[return]" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    _physicsWorld = [CCPhysicsNode node];
    //_physicsWorld.gravity = ccp(0.0, 0.0);
    _physicsWorld.debugDraw = YES;
    [self addChild:_physicsWorld];
    /*
    CGRect r = CGRectMake(20, 20, self.scene.contentSize.height-40, self.scene.contentSize.height-40);
    CGPoint r1[] = {CGPointMake(20, 20),
        CGPointMake(20, self.scene.contentSize.width-40),
        CGPointMake(self.scene.contentSize.width-40, self.scene.contentSize.width-40),
        CGPointMake(20,self.scene.contentSize.width-40)
    };
     */
    /*
    CCDrawNode *walls = [CCDrawNode node];
    [walls drawPolyWithVerts:r1 count:4 fillColor:[CCColor clearColor] borderWidth:2.0 borderColor:[CCColor blackColor]];
    walls.physicsBody = [CCPhysicsBody bodyWithPolylineFromRect:r cornerRadius:0];
    walls.physicsBody.type = CCPhysicsBodyTypeStatic;
    walls.physicsBody.elasticity = 1.0;
    walls.physicsBody.collisionType = @"wall";
    walls.physicsBody.collisionCategories = @[@"ball"];
    _physicsWorld.collisionDelegate = self;
    [_physicsWorld addChild:walls];
     */
    
    
    
    _line = [CCDrawNode node];
    [self addChild:_line];
    
    _grid = [CCSprite node];
    

    
    [self setupGrid:24];
    [self addChild:_grid];
    
    _currentConstellation = [constellation node];
    [self addChild:_currentConstellation];
    [_currentConstellation setID:@"one"];
    //_currentConstellation.contentSize = [self contentSize];
    //[_currentConstellation setVisible:TRUE];
    //[_physicsWorld addChild:_currentConstellation];
    //_currentConstellation.physicsBody.type = CCPhysicsBodyTypeStatic;
    //_currentConstellation.position = CGPointMake(self.contentSize.width * self.anchorPoint.x,
              //                       self.contentSize.height * self.anchorPoint.y);
   // NSLog([_constellation1 debugDescription]);
    
    //[self.p:walls];
    // done
	return self;
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
    oldpoint = CGPointMake([Utilities roundNumber:g.x toNearest:wid],[Utilities roundNumber:g.y toNearest:hei]);
    if (oldpoint.x > 0 && oldpoint.y > 0 && oldpoint.y < self.scene.contentSize.height && oldpoint.x < self.scene.contentSize.height)
    [_currentConstellation addStarAtX:oldpoint];
    
    //[self addChild:_constellation1]
    
    
    
    
}

-(void) touchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    

    
   // [_line clear];
   // [_line drawSegmentFrom:oldpoint to:[touch locationInNode:self] radius:3.0 color:[CCColor colorWithUIColor:[UIColor whiteColor]]];

        
        
    
    
}

- (void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    

    /*
    CGPoint location = [touch locationInNode:self];
    location.x = [Utilities roundNumber:location.x toNearest:34];
    location.y = [Utilities roundNumber:location.y toNearest:34];
    
    //SKSpriteNode *square = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(30, 30)];
    
    
    
    square.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:14 andCenter:CGPointMake(15, 15)];//
    
    //square.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(34, 34)];
    CGPoint vec =  [Utilities rwSub:location and:oldpoint];
    
    float len = [Utilities rwLength:vec];
    vec.x /= len;
    vec.y /= len;
    

    square.physicsBody.velocity = CGPointMake(vec.x * len, vec.y * len);
    square.physicsBody.elasticity = 1.0;
    //SKAction *action = [SKAction moveBy:CGVectorMake(0,-50.0) duration:1.0];
    square.physicsBody.type = CCPhysicsBodyTypeDynamic;
    square.physicsBody.friction = 1.0;

    square.physicsBody.mass = 1.0;
    square.physicsBody.collisionType = @"ball";
    square.physicsBody.collisionCategories = @[@"ball",@"wall"];
    
     
     //------------------------------------------------------
    square.physicsBody.categoryBitMask = APAColliderTypeBall;
    square.physicsBody.collisionBitMask =
    APAColliderTypeBall
    | APAColliderTypeWall;
    square.physicsBody.contactTestBitMask = APAColliderTypeBall | APAColliderTypeWall;
     //------------------------------------------------------
    
    [_line clear];
    //square.physicsBody.resting = true;
    //[square.physicsBody applyForce:CGVectorMake(0,-0.2)];
    
    
    //[square runAction:[SKAction repeatActionForever:action]];
    
    */




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
- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

// -----------------------------------------------------------------------

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
    [_grid addChild:grild];
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
    _currentConstellation = [constellation node];
    [self addChild:_currentConstellation];
    [_currentConstellation setID:@"two"];

}

@end
