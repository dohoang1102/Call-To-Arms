//
//  TempTankLevelScene.m
//  Call To Arms
//
//  Created by Eddie Watson on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TempTankLevelScene.h"

@implementation TempTankLevelScene

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        tempTankLevelLayer = [TempTankLevelLayer node];
        [self addChild:tempTankLevelLayer];
    }
    
    return self;
}

@end
