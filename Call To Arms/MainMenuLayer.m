//
//  MainMenuLayer.m
//  Call To Arms
//
//  Created by Eddie Watson on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMenuLayer.h"

@implementation MainMenuLayer

// Plays/transitions to the selected scene/menu
-(void)playScene:(CCMenuItemFont*)itemPassedIn {
    
    // TEMP IMPLEMENTATION FOR TEMP SCENES USED FOR DEVELOPMENT
    if ([itemPassedIn tag] == 100) {
        [[GameManager sharedGameManager] runSceneWithId:kTempTankLevel];
    } else if ([itemPassedIn tag] == 200) {
        [[GameManager sharedGameManager] runSceneWithId:kOptionsMenu];
    } else if ([itemPassedIn tag] == 300) {
        [[GameManager sharedGameManager] runSceneWithId:kTempSoldierLevel];
    } else {
        CCLOG(@"Tag was: %d", [itemPassedIn tag]);
    }
}

// Displays the Main Menu
-(void)displayMainMenu {
    CGSize screenSize = [CCDirector sharedDirector].winSize; 
   
    // Main Menu
    
    // TEMPORARY MENU FOR DEVELOPMENT
    CCMenuItemImage *moveTankButton = [CCMenuItemImage itemFromNormalImage:@"Move Tank.png"
                                                             selectedImage:@"Move Tank-selected.png" 
                                                             disabledImage:nil 
                                                                    target:self 
                                                                  selector:@selector(playScene:)];
    [moveTankButton setTag:100];
    CCMenuItemImage *mapViewButton = [CCMenuItemImage itemFromNormalImage:@"Map View.png" 
                                                      selectedImage:@"Map View-selected.png" 
                                                      disabledImage:nil 
                                                             target:self 
                                                           selector:@selector(playScene:)];
    [mapViewButton setTag:200];
    CCMenuItemImage *soldierButton = [CCMenuItemImage itemFromNormalImage:@"Soldier.png" 
                                                            selectedImage:@"Soldier-selected.png" 
                                                            disabledImage:nil 
                                                                   target:self 
                                                                 selector:@selector(playScene:)];
    [soldierButton setTag:300];
    
    mainMenu = [CCMenu menuWithItems:moveTankButton, mapViewButton, soldierButton, nil];
    [mainMenu alignItemsHorizontallyWithPadding:screenSize.width * 0.05];
    [mainMenu setPosition:ccp(screenSize.width / 2.0f, screenSize.height * 2.0f)];
    id moveAction = [CCMoveTo actionWithDuration:1.0f 
                                        position:ccp(screenSize.width / 2.0f, screenSize.height * 0.85f)];
    id moveEffect = [CCEaseIn actionWithAction:moveAction 
                                          rate:1.0f];
    [mainMenu runAction:moveEffect];
    [self addChild:mainMenu];
}


// Main init method
- (id)init
{
    self = [super init];
    if (self != nil) {
        
        // Background music
        [[GameManager sharedGameManager] playBackgroundTrack:BACKGROUND_TRACK_MAIN_MENU];
        
        CGSize screenSize = [CCDirector sharedDirector].winSize; 
        
        // Checks if running on iPad or iPhone and initializes appropriate background image
        CCSprite *background;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            background = [CCSprite spriteWithFile:@"Main Menu iPad.png"];
        } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            background = [CCSprite spriteWithFile:@"Main Menu iPhone.png"];
        }
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild:background];
        
        [self displayMainMenu];        
    }
    
    return self;
}
@end
