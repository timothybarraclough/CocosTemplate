//
//  AppDelegate.h
//  Astral_Cocos3.0
//
//  Created by Timothy J on 28/08/14.
//  Copyright timothy j 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "cocos2d.h"
#import "PdAudioController.h"
#import "PdBase.h"

@interface AppDelegate : CCAppDelegate
@property (strong, nonatomic) PdAudioController *ac;
@property (nonatomic) NSTimeInterval timeSinceStart;
@end
