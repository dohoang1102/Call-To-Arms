//
//  ParaRifle.m
//  Call To Arms
//
//  Created by Eddie Watson on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ParaRifle.h"

@implementation ParaRifle

// Synthesize class properties HERE



// Deallocation (make sure to free up memory!)
- (void)dealloc
{
    [super dealloc];
}

// Loads and initializes the various animations used for this class (from superclass GameSoldier)
// Crawling - soldier in prove moving forward
// Walking - soldier standing walking forward scanning left to right
// Running - soldier standing running forward with no scanning
- (void)initAnimations
{
    [self setCrawlingAnimation:[self loadPlistForAnimationWithName:@"Crawling" andPlistName:@"US Para Rifleman Annimation"]];
    [self setWalkingAnimation:[self loadPlistForAnimationWithName:@"Walking" andPlistName:@"US Para Rifleman Annimation"]];
    [self setRunningAnimation:[self loadPlistForAnimationWithName:@"Running" andPlistName:@"US Para Rifleman Annimation"]];
}


// Temporary testing of animations
- (void)crawlingAnimationExample
{
    // Animation from CCSpriteBatchNode
    id animateAction = [CCAnimate actionWithAnimation:crawlingAnimation restoreOriginalFrame:NO];
    id repeatAction = [CCRepeatForever actionWithAction:animateAction];
    
    // Set soldier to run animation.
    [mainSprite runAction:repeatAction];
    
    // Move soldier
    id moveAction = [CCMoveTo actionWithDuration:24.0f position:ccp(100, 100)];
    [mainSprite runAction:[CCSequence actions:moveAction, [CCCallFunc actionWithTarget:self selector:@selector(walkingAnimationExample)], nil]];
}

- (void)walkingAnimationExample
{
    id animateAction = [CCAnimate actionWithAnimation:walkingAnimation restoreOriginalFrame:NO];
    id repeatAction = [CCRepeatForever actionWithAction:animateAction];
    [mainSprite runAction:repeatAction];
    id moveAction = [CCMoveTo actionWithDuration:18.0f position:ccp(200, 200)];
    [mainSprite runAction:[CCSequence actions:moveAction, [CCCallFunc actionWithTarget:self selector:@selector(runningAnimationExample)], nil]];
}

- (void)runningAnimationExample
{
    id animateAction = [CCAnimate actionWithAnimation:runningAnimation restoreOriginalFrame:NO];
    id repeatAction = [CCRepeatForever actionWithAction:animateAction];
    [mainSprite runAction:repeatAction];
    id moveAction = [CCMoveTo actionWithDuration:7.0f position:ccp(300, 300)];
    [mainSprite runAction:[CCSequence actions:moveAction, [CCCallFunc actionWithTarget:referringLayer selector:@selector(returnToMainMenu)], nil]];
}



// Returns the position of this unit in the array of objects in the game layer (unitsInLayer)
- (int)getUnitsInLayerObjectPosition
{
    return unitsInLayerObjectPosition;
}


// Sets the recorded position of this object in the game layers array of units (unitsInLayer)
- (void)setUnitsInLayerObjectPosition:(int)position
{
    unitsInLayerObjectPosition = position;
}

// Main init method
- (id)init
{
    if (self=[super init])
    {
        CCLOG(@"# ParaRifle # - INITIALIZED!");
        [self initAnimations];      // Initialize animations
        
        // TEMP
        mainSprite = [CCSprite spriteWithSpriteFrameName:@"US - Para - Prone.png"];
        [mainSprite setPosition:ccp(0, 0)];    // Starting position of (100,100)
        [mainSprite setRotation:45];
        //[mainSprite setScale:0.5f];
    }
    
    return self;
}

@end
