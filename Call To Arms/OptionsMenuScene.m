//
//  OptionsMenuScene.m
//  Call To Arms
//
//  Created by Eddie Watson on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OptionsMenuScene.h"

@implementation OptionsMenuScene

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        optionsMenuLayer = [OptionsMenuLayer node];
        [self addChild:optionsMenuLayer];
    }
    
    return self;
}

@end
