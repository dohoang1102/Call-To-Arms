//
//  TempSoldierLevelLayer.h
//  Call To Arms
//
//  Created by Eddie Watson on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"
#import "GameManager.h"

@interface TempSoldierLevelLayer : CCLayer
{
    // Variables will go here... TO COME
    CCSprite *tempSoldier;
    
    //ParaRifle *unit;
    
    CCSpriteBatchNode *tempBatchNode;
    
    // Pointers
    
    NSMutableArray *unitsInLayer;
    int unitsInLayerCount;
}

@property (nonatomic, assign) CCSpriteBatchNode *tempBatchNode;
//@property (nonatomic, retain) NSMutableArray *unitsInLayer;

- (void)returnToMainMenu;


@end
