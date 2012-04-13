//
//  TempSoldierLevelScene.m
//  Call To Arms
//
//  Created by Eddie Watson on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TempSoldierLevelScene.h"

@implementation TempSoldierLevelScene

- (id)init
{
    if (self=[super init])
    {
        tempSoldierLevelLayer = [TempSoldierLevelLayer node];
        [self addChild:tempSoldierLevelLayer];
    }
    
    return self;
}

@end
