//
//  AppDelegate.h
//  AstralCocos
//
//  Created by Timothy J on 3/09/14.
//  Copyright Apportable 2014. All rights reserved.
//

#import "cocos2d.h"

@interface AstralCocosAppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic, weak) IBOutlet NSWindow    *window;
@property (nonatomic, weak) IBOutlet CCGLView    *glView;

- (IBAction)toggleFullScreen:(id)sender;

@end
