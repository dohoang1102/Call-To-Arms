//
//  GameUnits.h
//  Call To Arms
//
//  Created by Eddie Watson on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"

@interface GameUnits : GameObject
{
    // Spaceholders for units to have a 2nd and 3rd sprite (turret, MG, etc)
    // as well as a selection indicator sprite
    CCSprite *secondSprite, *thirdSprite, *selectionIndicator;
}

@property (nonatomic, retain) CCSprite *secondSprite;
@property (nonatomic, retain) CCSprite *thirdSprite;
@property (nonatomic, retain) CCSprite *selectionIndicator;

@end
