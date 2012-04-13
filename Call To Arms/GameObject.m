//
//  GameObject.m
//  Call To Arms
//
//  Created by Eddie Watson on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"

@implementation GameObject

@synthesize referringLayer;
@synthesize mainSprite;

- (void)dealloc
{
    [TempSoldierLevelLayer release];
    [mainSprite release];
    [super dealloc];
}

@end
