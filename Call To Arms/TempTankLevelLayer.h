//
//  TempTankLevelLayer.h
//  Call To Arms
//
//  Created by Eddie Watson on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"
#import "GameManager.h"

#import "math.h"

@interface TempTankLevelLayer : CCLayer
{
    CCSprite *tankHull;
    CCSprite *tankTop;
    CCSprite *selectionIndicator;
    CCSprite *moveButton;
    CCSprite *fireButton;
    CCSprite *explosion;
    
    CCSprite *germanHull;
    CCSprite *germanTurret;
    
    float tankRotation, rotateDuration;
    double opposite, adjacent, hypotenuse, degrees, rotation;
    CGPoint moveToLocation;
    CGPoint explosionLocation;
    SelectionType selection;
}

// returns a CCScene that contains the TempTankLayer as the only child
//+(CCScene *) scene;

@end
