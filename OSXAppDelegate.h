//
//  AppDelegate.h
//  empty
//
//  Created by Timothy J on 3/09/14.
//  Copyright timothy j 2014. All rights reserved.
//

#import "cocos2d.h"
#import "PdAudioController.h"


@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic, weak) IBOutlet NSWindow    *window;
@property (nonatomic, weak) IBOutlet CCGLView    *view;
//@property (strong, nonatomic) PdAudioController *ac;

- (IBAction)toggleFullScreen:(id)sender;

@end
