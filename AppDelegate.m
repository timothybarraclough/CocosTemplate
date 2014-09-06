//
//  AppDelegate.m
//  Astral_Cocos3.0
//
//  Created by Timothy J on 28/08/14.
//  Copyright timothy j 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "AppDelegate.h"
#import "IntroScene.h"
#import "HelloWorldScene.h"

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.ac = [[PdAudioController alloc] init];
	[self.ac configurePlaybackWithSampleRate:22050 numberChannels:1 inputEnabled:NO mixingEnabled:NO];
    [self.ac configureTicksPerBuffer:4];
    [PdBase addToSearchPath:@"/puredata/"];
	[PdBase openFile:@"/patch.pd" path:[[NSBundle mainBundle] resourcePath]];
	[self.ac setActive:YES];
    
    [CCBReader configureCCFileUtils];
	// This is the only app delegate method you need to implement when inheriting from CCAppDelegate.
	// This method is a good place to add one time setup code that only runs when your app is first launched.
	
	// Setup Cocos2D with reasonable defaults for everything.
	// There are a number of simple options you can change.
	// If you want more flexibility, you can configure Cocos2D yourself instead of calling setupCocos2dWithOptions:.
	[self setupCocos2dWithOptions:@{
		// Show the FPS and draw call label.
		CCSetupShowDebugStats: @(YES),
		
		// More examples of options you might want to fiddle with:
		// (See CCAppDelegate.h for more information)
		
		// Use a 16 bit color buffer: 
//		CCSetupPixelFormat: kEAGLColorFormatRGB565,
		// Use a simplified coordinate system that is shared across devices.
//		CCSetupScreenMode: CCScreenModeFixed,
		// Run in portrait mode.
//		CCSetupScreenOrientation: CCScreenOrientationPortrait,
		// Run at a reduced framerate.
//		CCSetupAnimationInterval: @(1.0/30.0),
		// Run the fixed timestep extra fast.
//		CCSetupFixedUpdateInterval: @(1.0/180.0),
		// Make iPad's act like they run at a 2x content scale. (iPad retina 4x)
//		CCSetupTabletScale2X: @(YES),
        CCSetupScreenMode: CCScreenOrientationLandscape,
	}];
    
    
    
    
    
   // NSLog(CC);
    

    
    
	
	return YES;
}
 

-(CCScene *)startScene
{
	// This method should return the very first scene to be run when your app starts.
	return [HelloWorldScene scene];
    //return [CCBReader loadAsScene:@"MainScene"];
}

@end
