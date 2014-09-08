//
//  HelloWorldScene.h
//  Astral_Cocos3.0
//
//  Created by Timothy J on 28/08/14.
//  Copyright timothy j 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using Cocos2D v3
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "Utilities.h"
#import "PdBase.h"
#ifdef __CC_PLATFORM_IOS
#import <UIKit/UIKit.h>

#endif

// -----------------------------------------------------------------------

/**
 *  The main scene
 */
@interface HelloWorldScene : CCScene <CCPhysicsCollisionDelegate>

// -----------------------------------------------------------------------

+ (HelloWorldScene *)scene;
- (id)init;


// -----------------------------------------------------------------------
@end