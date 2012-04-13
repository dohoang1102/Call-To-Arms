//
//  TempMapLevelScene.m
//  Call To Arms
//
//  Created by Eddie Watson on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TempMapLevelScene.h"

@implementation TempMapLevelScene

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        tempMapLevelLayer = [TempMapLevelLayer node];
        [self addChild:tempMapLevelLayer];
    }
    
    return self;
}

@end
