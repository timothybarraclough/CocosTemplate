//
//  AppDelegate.m
//  empty
//
//  Created by Timothy J on 3/09/14.
//  Copyright timothy j 2014. All rights reserved.
//

#import "OSXAppDelegate.h"
#import "CCBReader.h"
#import "HelloWorldScene.h"

@implementation AppDelegate

@synthesize pdAudioUnit;

static NSString *const kPatchName = @"patch.pd";

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSString* configPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Published-iOS"]; // TODO: add support for Published-Android support
    configPath = [configPath stringByAppendingPathComponent:@"configCocos2d.plist"];
    
    NSMutableDictionary* cocos2dSetup = [NSMutableDictionary dictionaryWithContentsOfFile:configPath];
    
    CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
    
    // Setup file utils for use with SpriteBuilder
    [sharedFileUtils setEnableiPhoneResourcesOniPad:NO];
    
    sharedFileUtils.directoriesDict =
    [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"resources-tablet", CCFileUtilsSuffixiPad,
     @"resources-tablethd", CCFileUtilsSuffixiPadHD,
     @"resources-phone", CCFileUtilsSuffixiPhone,
     @"resources-phonehd", CCFileUtilsSuffixiPhoneHD,
     @"resources-phone", CCFileUtilsSuffixiPhone5,
     @"resources-phonehd", CCFileUtilsSuffixiPhone5HD,
     @"resources-tablet", CCFileUtilsSuffixMac,
     @"resources-tablethd", CCFileUtilsSuffixMacHD,
     @"", CCFileUtilsSuffixDefault,
     nil];
    
    sharedFileUtils.searchPath =
    [NSArray arrayWithObjects:
     [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Published-iOS"],
     [[NSBundle mainBundle] resourcePath],
     nil];
    
	sharedFileUtils.enableiPhoneResourcesOniPad = YES;
    sharedFileUtils.searchMode = CCFileUtilsSearchModeDirectory;
   // sharedFileUtils.searchMode =CCFileUtilsSearchModeSuffix;
    [sharedFileUtils buildSearchResolutionsOrder];
    
    
    [sharedFileUtils loadFilenameLookupDictionaryFromFile:@"fileLookup.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] loadSpriteFrameLookupDictionaryFromFile:@"spriteFrameFileList.plist"];
    
    //[CCBReader configureCCFileUtils];
    [self setupCocos2dWithOptions:cocos2dSetup];
    
    
    
    
    /*
	CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];

	// enable FPS and SPF
	[director setDisplayStats:YES];
	
	// connect the OpenGL view with the director
	[director setView:_view];

	// EXPERIMENTAL stuff.
	// 'Effects' don't work correctly when autoscale is turned on.
	// Use kCCDirectorResize_NoScale if you don't want auto-scaling.
	[director setResizeMode:kCCDirectorResize_AutoScale];
	
	// Enable "moving" mouse event. Default no.
	[_window setAcceptsMouseMovedEvents:NO];
	
	// Center main window
	[_window center];
	
	[director runWithScene:[HelloWorldScene scene]];
    */
}

- (void) setupCocos2dWithOptions:(NSDictionary*)config
{
	CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];
    
	// enable FPS and SPF
	[director setDisplayStats:YES];
	
	// connect the OpenGL view with the director
	[director setView:self.view];
    
	// EXPERIMENTAL stuff.
	// 'Effects' don't work correctly when autoscale is turned on.
	// Use kCCDirectorResize_NoScale if you don't want auto-scaling.
	//[director setResizeMode:kCCDirectorResize_AutoScale];
    [director setResizeMode:kCCDirectorResize_NoScale];
	
	// Enable "moving" mouse event. Default no.
	[_window setAcceptsMouseMovedEvents:NO];
	
	// Center main window
	[_window center];
	
	[director runWithScene:[self startScene]];
    
    // PURE DATA INITIALIZATION -----------------------------------------------
    
    /*
    self.pdAudioUnit = [[PdAudioUnit alloc] init];
	[self.pdAudioUnit configureWithSampleRate:44100 numberChannels:2 inputEnabled:NO];
	[self.pdAudioUnit print];
    //[self.pdAudioUnit ]
    
	void *handle = [PdBase openFile:kPatchName path:[[NSBundle mainBundle] resourcePath]];
	if( handle ) {
		AU_LOG(@"patch successfully opened %@.", kPatchName);
	} else {
		AU_LOG(@"error: patch failed to open %@.", kPatchName);
	}
    
	[self performSelector:@selector(startAudio) withObject:nil afterDelay:1];
     */
}

- (void)startAudio {
	self.pdAudioUnit.active = YES;
	AU_LOG(@"PdAudioUnit audio active: %@", (self.pdAudioUnit.isActive ? @"YES" : @"NO" ) );
}


- (CCScene*) startScene
{
    return [IntroScene scene];
    //return [CCBReader loadAsScene:@"MainScene"];
}


- (BOOL) applicationShouldTerminateAfterLastWindowClosed: (NSApplication *) theApplication
{
	return YES;
}

- (void)dealloc
{
	[[CCDirector sharedDirector] end];
}

#pragma mark AppDelegate - IBActions

- (IBAction)toggleFullScreen: (id)sender
{
	CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];
	[director setFullScreen: ! [director isFullScreen] ];
}

@end
