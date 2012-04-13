//
//  GameObject.h
//  Call To Arms
//
//  Created by Eddie Watson on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "TempSoldierLevelLayer.h"

@interface GameObject : CCNode
{
    TempSoldierLevelLayer *referringLayer;
    
    // Every game object has at least one sprite associated with it
    CCSprite *mainSprite;
}

@property (nonatomic, retain) TempSoldierLevelLayer *referringLayer;
@property (nonatomic, retain) CCSprite *mainSprite;

@end
