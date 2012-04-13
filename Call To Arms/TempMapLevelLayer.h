//
//  TempMapLevelLayer.h
//  Call To Arms
//
//  Created by Eddie Watson on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"
#import "GameManager.h"

@interface TempMapLevelLayer : CCLayer
{
    CCSprite *bgmBL;
    CCSprite *bgmBR;
    CCSprite *bgmTL;
    CCSprite *bgmTR;
    
    CCSprite *germanTankHull;
    CCSprite *germanTankTurret;
    CCSprite *germanTankSelectIndicator;
    
    CCSprite *americanTankHull;
    CCSprite *americanTankTurret;
    
    CCSprite *quitButton;
    
    //CGPoint touchLocation;
    CGSize mapSize;
    float scaleFactor;
    float tankScaleFactor;
}

@end
