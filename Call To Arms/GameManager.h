//
//  GameManager.h
//  Call To Arms
//
//  Created by Eddie Watson on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "SimpleAudioEngine.h"

@interface GameManager : NSObject
{
    SceneTypes currentScene;
    
    mapName mapToPlay;
    
    // Audio stuff
    BOOL hasAudioBeenInitialized;
    GameManagerSoundState managerSoundState;
    SimpleAudioEngine *soundEngine;
    NSMutableDictionary *listOfSoundEffectFiles;
    NSMutableDictionary *soundEffectsState;
}

@property (readwrite) mapName mapToPlay;
@property (readwrite) GameManagerSoundState managerSoundState;
@property (nonatomic, retain) NSMutableDictionary *listOfSoundEffectFiles;
@property (nonatomic, retain) NSMutableDictionary *soundEffectsState;

+ (GameManager*)sharedGameManager;
- (void)runSceneWithId:(SceneTypes)sceneID;

// Audio
- (void)setupAudioEngine;
- (ALuint)playSoundEffect:(NSString *)soundEffectKey;
- (void)stopSoundEffect:(ALuint)soundEffectID;
- (void)playBackgroundTrack:(NSString *)trackFileName;

// Scene demension
- (CGSize)getDimensionsOfCurrentScene;

@end
