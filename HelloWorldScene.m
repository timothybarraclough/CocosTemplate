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
#import "constellationWindow.h"

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


@property constellationWindow* constellationFrame;
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

+(NSArray *)constellationNames{
    
    
    static NSArray *names;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
       
        
        names =@[@"Ceres",
                 @"Pluto",
                 @"Saturn",
                 @"Jupiter"];
    });
        
    return names;
}


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
    
    //background.
    [self addChild:background];
    // Create a back button
    CGSize constWindowSize = CGSizeMake (self.scene.contentSize.height * .95f,self.scene.contentSize.height * .95f);
    self.constellationFrame = [[constellationWindow alloc]initWithSize:constWindowSize andDivisions:24];
    self.constellationFrame.positionType = CCPositionTypeNormalized;
    self.constellationFrame.position = ccp(0.62,0.5);
    self.constellationFrame.userInteractionEnabled = true;
    [self addChild:self.constellationFrame];
   /* self.constellationNames = [[NSArray alloc]initWithObjects:@"Ceres",
    @"Pluto",
    @"Saturn",
    @"Jupiter",
    nil];
    */
    //, nil
    //self.constellationNames = [NSArray arrayWithObjects:
    
    /*
    divisions = 18;
    wid = self.scene.contentSize.height/divisions;
    hei = self.scene.contentSize.height/divisions;
    
    
    _constellationBank = [[NSMutableDictionary alloc]init];
    
    
    
    
    _button = [CCButton buttonWithTitle:@"finish" fontName:@"Verdana-Bold" fontSize:100.0f];
    _button.positionType = CCPositionTypeNormalized;
    _button.position = ccp(0.75f, 0.5f);
    [_button setTarget:self selector:@selector(finishConstellation:)];
    
    [self addChild:_button];
    
    [CCBReader configureCCFileUtils];
     */
    
    CGSize menuSize = CGSizeMake(self.scene.contentSize.width * .125f,self.scene.contentSize.height * .90f);
    buttonMenu *sideBar = [[buttonMenu alloc]initWithSize:menuSize and:4];
    sideBar.positionType = CCPositionTypeNormalized;
    sideBar.position = ccp(0.15,0.5);
    [self addChild:sideBar];
    
    /*
    CCNode *sideBar = [CCNode node];
    
    //sideBar.position = CGPointMake(hei*divisions + hei, 0);
    sideBar.contentSize = CGSizeMake(self.scene.contentSize.width/4.0, self.contentSize.height);//cSize(0.25, 1.0);
    sideBar.positionType = CCPositionTypeNormalized;
    sideBar.position = ccp(0.25,-0.45);
    

    
    CCSpriteFrame *r1 = [CCSpriteFrame frameWithTexture:[CCTexture textureWithFile:@"red.png"] rectInPixels:CGRectMake(0,0,hei,hei) rotated:false offset:CGPointZero originalSize:CGSizeMake(100, 100)];
    CCSpriteFrame *r2 = [CCSpriteFrame frameWithTexture:[CCTexture textureWithFile:@"redSel.png"] rectInPixels:CGRectMake(0,0,hei,hei) rotated:false offset:CGPointZero originalSize:CGSizeMake(100, 100)];
    CCButton *red = [CCButton buttonWithTitle:@"" spriteFrame:r1 highlightedSpriteFrame:r2 disabledSpriteFrame:r2];
    [red setPosition:CGPointMake(0,1*self.scene.contentSize.height/8)];
    [red setTarget:self selector:@selector(changeConstButton:)];
    [red setName:@"pluto"];
    [sideBar addChild:red];
    
    
    CCSpriteFrame *b1 = [CCSpriteFrame frameWithTexture:[CCTexture textureWithFile:@"blue.png"] rectInPixels:CGRectMake(0,0,hei,hei) rotated:false offset:CGPointZero originalSize:CGSizeMake(hei, hei)];
    CCSpriteFrame *b2 = [CCSpriteFrame frameWithTexture:[CCTexture textureWithFile:@"blueSel.png"] rectInPixels:CGRectMake(0,0,hei,hei) rotated:false offset:CGPointZero originalSize:CGSizeMake(hei, hei)];
    CCButton *blue = [CCButton buttonWithTitle:@"" spriteFrame:b1 highlightedSpriteFrame:b2 disabledSpriteFrame:r2];
    [blue setPosition:CGPointMake(0,3*self.scene.contentSize.height/8)];
    [blue setTarget:self selector:@selector(changeConstButton:)];
    [blue setName:@"ceres"];
    [sideBar addChild:blue];
    
    CCSpriteFrame *g1 = [CCSpriteFrame frameWithTexture:[CCTexture textureWithFile:@"green.png"] rectInPixels:CGRectMake(0,0,112,112) rotated:false offset:CGPointZero originalSize:CGSizeMake(hei, hei)];
    CCSpriteFrame *g2 = [CCSpriteFrame frameWithTexture:[CCTexture textureWithFile:@"greenSel.png"] rectInPixels:CGRectMake(0,0,112,112) rotated:false offset:CGPointZero originalSize:CGSizeMake(hei, hei)];
    CCButton *green = [CCButton buttonWithTitle:@"" spriteFrame:g1 highlightedSpriteFrame:g2 disabledSpriteFrame:g2];
    [green setPosition:CGPointMake(0,5*self.scene.contentSize.height/8)];
    [green setTarget:self selector:@selector(changeConstButton:)];
    [green setName:@"jupiter"];
    [sideBar addChild:green];
    
    CCSpriteFrame *o1 = [CCSpriteFrame frameWithTexture:[CCTexture textureWithFile:@"orange.png"] rectInPixels:CGRectMake(0,0,112,112) rotated:false offset:CGPointZero originalSize:CGSizeMake(100, 100)];
    CCSpriteFrame *o2 = [CCSpriteFrame frameWithTexture:[CCTexture textureWithFile:@"orangeSel.png"] rectInPixels:CGRectMake(0,0,112,112) rotated:false offset:CGPointZero originalSize:CGSizeMake(100, 100)];
    CCButton *oran = [CCButton buttonWithTitle:@"" spriteFrame:o1 highlightedSpriteFrame:o2 disabledSpriteFrame:o2];
    [oran setPosition:CGPointMake(0,7*self.scene.contentSize.height/8)];
    [oran setTarget:self selector:@selector(changeConstButton:)];
    [oran setName:@"saturn"];
    [sideBar addChild:oran];
    [self addChild:sideBar];
*/
    
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
    
    
    /*
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
     */
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
    oldpoint = CGPointMake([Utilities roundNumber:g.x toNearest:wid],[Utilities roundNumber:g.y toNearest:wid]);
    if (oldpoint.x > 0 && oldpoint.y > 0 && oldpoint.y < self.scene.contentSize.height && oldpoint.x < self.scene.contentSize.height)
    [_currentConstellation addStarAtX:oldpoint];
    
    //CCPhysicsBody
    
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
    [self.constellationFrame.currentConstellation setID:g.name];
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
    CCActionFadeTo *fadeIn = [CCActionFadeTo actionWithDuration:0.5 opacity:0.0];
    CCActionFadeTo *fadeOut = [CCActionFadeTo actionWithDuration:0.5 opacity:1.0];
    
    CCActionSequence *pulseSequence = [CCActionSequence actions:
                                 fadeIn, // I get a warning about incompatible pointer types...
                                 fadeOut,
                                 nil];
    [self runAction:[CCActionRepeatForever actionWithAction:pulseSequence]];
    [_grid addChild:grild];
    //_grid.shader = [CCShader shaderNamed:@"MotionBlur"];
}

-(void)constellationEnded{
    
    if ([self.constellationFrame.constellationBank objectForKey:[self.constellationFrame.currentConstellation getID]] != nil){
        [[self.constellationFrame.constellationBank objectForKey:[self.constellationFrame.currentConstellation getID]] removeFromParentAndCleanup:YES];
        [self.constellationFrame.constellationBank removeObjectForKey:[self.constellationFrame.currentConstellation getID]];
        
    }
    
    self.constellationFrame.constellationBank[[self.constellationFrame.currentConstellation getID]] = self.constellationFrame.currentConstellation;
    //[self addChild: _constellationBank[[_currentConstellation getID]]];
    
    //[_currentConstellation removeFromParentAndCleanup:YES];
    _currentConstellation = [constellation node];
    [self addChild:_currentConstellation];
    [_currentConstellation setID:@"two"];

}

-(float)getDivision{
    return hei;
}

@end
