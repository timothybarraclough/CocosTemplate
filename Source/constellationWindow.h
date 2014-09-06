//
//  constellationWindow.h
//  AstralCocos
//
//  Created by Timothy J on 5/09/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface constellationWindow : CCNode

//+ (constellationWindow *)scene;
- (id)initWithSize:(CGSize)windowSize andDivisions:(int)divs;
-(float)getDivision;

@end
