//
//  GameSoldier.h
//  Call To Arms
//
//  Created by Eddie Watson on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameUnits.h"

@interface GameSoldier : GameUnits
{
    CCAnimation *crawlingAnimation;
    CCAnimation *walkingAnimation;
    CCAnimation *runningAnimation;
}

@property (nonatomic, retain) CCAnimation *crawlingAnimation;
@property (nonatomic, retain) CCAnimation *walkingAnimation;
@property (nonatomic, retain) CCAnimation *runningAnimation;

- (CCAnimation *)loadPlistForAnimationWithName:(NSString *)animationName andPlistName:(NSString *)plistName;

@end
