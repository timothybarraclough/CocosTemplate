//
//  constellationWindow.h
//  AstralCocos
//
//  Created by Timothy J on 5/09/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "cocos2d.h"
#import "constellation.h"

@interface constellationWindow : CCNode

@property CCSprite* grid;
@property constellation *currentConstellation;
@property NSMutableDictionary * constellationBank;

//+ (constellationWindow *)scene;
- (id)initWithSize:(CGSize)windowSize andDivisions:(int)divs;
-(float)getDivision;

@end
