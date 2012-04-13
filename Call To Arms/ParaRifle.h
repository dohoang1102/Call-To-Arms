//
//  ParaRifle.h
//  Call To Arms
//
//  Created by Eddie Watson on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameSoldier.h"

@interface ParaRifle : GameSoldier
{
    int unitsInLayerObjectPosition;
    classType classType;
}

- (void)crawlingAnimationExample;
- (void)walkingAnimationExample;
- (void)runningAnimationExample;
- (void)setUnitsInLayerObjectPosition:(int)position;
- (int)getUnitsInLayerObjectPosition;

@end
