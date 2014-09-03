//
//  main.m
//  Example
//
//  Created by Viktor on 8/12/13.
//  Copyright Apportable 2013. All rights reserved.
//

#ifdef __CC_PLATFORM_IOS
#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    
    @autoreleasepool {
        int retVal = UIApplicationMain(argc, argv, nil, @"AppDelegate");
        return retVal;
    }
}
#else

#import <Cocoa/Cocoa.h>
#import "cocos2d.h"

int main(int argc, const char * argv[])
{
   // [CCGLView load_];
    return NSApplicationMain(argc, argv);
}


#endif






