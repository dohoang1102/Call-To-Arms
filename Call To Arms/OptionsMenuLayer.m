//
//  OptionsMenuLayer.m
//  Call To Arms
//
//  Created by Eddie Watson on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OptionsMenuLayer.h"

@implementation OptionsMenuLayer

// Play the map selected
- (void)playMap:(CCMenuItemFont *)itemPassedIn
{
    if ([itemPassedIn tag] == 1)
    {
        [GameManager sharedGameManager].mapToPlay = kMapCharlie;
        [[GameManager sharedGameManager] runSceneWithId:kTempMapLevel];
    } else if ([itemPassedIn tag] == 2) {
        [GameManager sharedGameManager].mapToPlay = kMapChemin;
        [[GameManager sharedGameManager] runSceneWithId:kTempMapLevel];
    } else if ([itemPassedIn tag] == 3) {
        [GameManager sharedGameManager].mapToPlay = kMapDogW;
        [[GameManager sharedGameManager] runSceneWithId:kTempMapLevel];
    } else {
        [[GameManager sharedGameManager] runSceneWithId:kMainMenu];
    }
}

// Displays the Options Menu
-(void)displayOptionsMenu {
    
    CGSize screenSize = [CCDirector sharedDirector].winSize; 
    
    // TEMPORARY MENU FOR DEVELOPMENT
    CCMenuItemFont *charlie = [CCMenuItemFont itemFromString:@"Charlie" target:self selector:@selector(playMap:)];
    [charlie setTag:1];
    
    CCMenuItemFont *chemin = [CCMenuItemFont itemFromString:@"Chemin" target:self selector:@selector(playMap:)];
    [chemin setTag:2];

    CCMenuItemFont *dogW = [CCMenuItemFont itemFromString:@"DogW" target:self selector:@selector(playMap:)];
    [dogW setTag:3];
    
    CCMenuItemFont *mainMenu = [CCMenuItemFont itemFromString:@"Return to Main Menu" target:self selector:@selector(playMap:)];
    [mainMenu setTag:4];
    
    optionsMenu = [CCMenu menuWithItems:charlie, chemin, dogW, mainMenu, nil];
    [optionsMenu alignItemsVerticallyWithPadding:screenSize.width *0.05];
    [optionsMenu setPosition:ccp(screenSize.width / 2.0f, screenSize.height / 2.0f)];
    
    [self addChild:optionsMenu];
}


// Main init method
- (id)init
{
    self = [super init];
    if (self != nil) 
        [self displayOptionsMenu];        
    
    return self;
}
@end
