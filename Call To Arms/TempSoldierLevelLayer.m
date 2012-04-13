//
//  TempSoldierLevelLayer.m
//  Call To Arms
//
//  Created by Eddie Watson on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TempSoldierLevelLayer.h"
#import "Objects.h"


@implementation TempSoldierLevelLayer

//@synthesize unitsInLayer;
@synthesize tempBatchNode;


// Function to call to return to Main Menu
- (void)returnToMainMenu
{
    [[GameManager sharedGameManager] runSceneWithId:kMainMenu];
}

// Main init method
- (id)init
{
    if (self=[super init])
    {
        // ENABLE TOUCHES HERE...
        
        // Create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Temp Soldier Level" fontName:@"Marker Felt" fontSize:64];    
        
        // Get screen size from CCDirector
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        // Position the label on the center of the screen
		label.position =  ccp(screenSize.width/2 , screenSize.height/2);
		
		// add the label as a child to this Layer
		[self addChild: label];
        
        
        // Creation of CCSpriteBatchNode for this level
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Temp American Forces Sprite Sheet.plist"];
        tempBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"Temp American Forces Sprite Sheet.png"];
        
        // Initialize the array of units in the layer
        unitsInLayer = [[NSMutableArray alloc] init];
        unitsInLayerCount = 0;
        
        
        // Create a ParaRifle soldier object
        // ---
        // isKindOfClass or isMemeberOfClass might be good here
        // ex: if ([foo isKindOfClass:[NSBar class]]) ...
        
        [unitsInLayer addObject:[[[ParaRifle alloc] init] autorelease]];
        [[unitsInLayer objectAtIndex:unitsInLayerCount] setUnitsInLayerObjectPosition:unitsInLayerCount];
        
        [tempBatchNode addChild:[[unitsInLayer objectAtIndex:0] mainSprite]];
        [[unitsInLayer objectAtIndex:0] setReferringLayer:self];        
        
        // Add batch node to the layer
        [self addChild:tempBatchNode];
        
        // Test the temp animation example (animation controlled and set via object)
        [[unitsInLayer objectAtIndex:0] crawlingAnimationExample];
        
    }
    
    return self;
}

@end
