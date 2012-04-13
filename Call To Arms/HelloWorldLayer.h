//
//  HelloWorldLayer.h
//  Call To Arms
//
//  Created by Eddie Watson on 3/7/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    CCSprite *tankHull;
    CCSprite *tankTop;
    float tankRotation, rotateDuration;
    double opposite, adjacent, hypotenuse, degrees, rotation;
    CGPoint moveToLocation;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
