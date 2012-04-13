//
//  GameUnits.m
//  Call To Arms
//
//  Created by Eddie Watson on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameUnits.h"

@implementation GameUnits

@synthesize secondSprite;
@synthesize thirdSprite;
@synthesize selectionIndicator;


- (void)dealloc
{
    [secondSprite release];
    [thirdSprite release];
    [selectionIndicator release];
    [super dealloc];
}

@end
