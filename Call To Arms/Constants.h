//
//  Constants.h
//  Call To Arms
//
//  Created by Eddie Watson on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#pragma mark -
#pragma mark Temporary
// TEMPORARY FUN
// Defined values for tank parts
#define TANK_HULL 1
#define TANK_TOP 2
#define TANK_ROTATION_PER_SECOND 40
#define TANK_MOVEMENT_PER_SECOND 100
#define TURRET_ROTATION_PER_SECOND 60

// Definition of tag values
#define EXPLOSION_TAG_VALUE 10
#define SELECTION_TAG_VALUE 100
#define MOVE_BUTTON_TAG_VALUE 101
#define FIRE_BUTTON_TAG_VALUE 102
#define MOVE_LABEL_TAG_VALUE 201
#define FIRE_LABEL_TAG_VALUE 202


#pragma mark -
#pragma mark Enumerated Types
typedef enum {
    kObjectTypeNone,
    kUnitVehicleTank_M4Sherman
} GameObjectType;

typedef enum {
    kNoSelection,
    kTankSelected,
    kMoveSelected,
    kFireSelected
} SelectionType;

#pragma mark -
#pragma Scene Types
// Defines the scene types for GameManager to run.
typedef enum {
    kNoSceneUninitialized = 0,
    kGameIntro = 1,
    kMainMenu = 2,
    kOptionsMenu = 3,
    kPlayGameMenu = 4,
    kMultiplayerGame = 5,
    kPlaySingleGame = 41,
    kPlayShortCampaign = 42,
    kPlayGrandCampaign = 43,
    kSetupGame = 401,
    
    kTempTankLevel = 500,
    kTempMapLevel = 501,
    kTempSoldierLevel = 502
} SceneTypes;

// Text label debugging.  0 for off and 1 for on.
#define DEBUGGING_STATUS 0


#pragma mark -
#pragma mark Audio Constants
// AUDIO CONSTANTS
// ---------------

// Maximum cycles to wait for audio to load
#define AUDIO_MAX_WAITTIME 150

// Type definition for audiomanager states
typedef enum {
    kAudioManagerUnitialized=0,
    kAudioManagerFailed=1,
    kAudioManagerInitializing=2,
    kAudioManagerInitialized=100,
    kAudioManagerLoading=200,
    kAudioManagerReady=300
} GameManagerSoundState;

// Defines terms for if sound effects have loaded or not
#define SFX_NOTLOADED NO
#define SFX_LOADED YES

// Defines shortcuts for playing and stopping sound effects
#define PLAYSOUNDEFFECT(...) \
[[GameManager sharedGameManager] playSoundEffect:@#__VA_ARGS__]

#define STOPSOUNDEFFECT(...) \
[[GameManager sharedGameManager] stopSoundEffect:__VA_ARGS__]

// Background Music by Scene
// Menu Scenes
#define BACKGROUND_TRACK_MAIN_MENU @"BGM Main Menu.mp3"


#pragma mark -
#pragma mark Filename Definitions
// FILENAME DEFINITIONS FOR CENTRALIZED LOCATION
#define M4_SHERMAN_HULL @"Sherman Tank - Hull - Green.png"
#define M4_SHERMAN_TURRET @"Sherman Tank - Turret - Green.png"


#pragma mark -
#pragma mark Maps
// Constants for map stuff (size, etc)
typedef enum {
    kNoMapSelected,
    kMapCharlie,
    kMapChemin,
    kMapDogG,
    kMapDogW
} mapName;


#pragma mark -
#pragma mark Classes
// Constants for type of class/object to create
typedef enum {
    kClassType_ParaRifle,
    kClassType_M4A1Sherman
} classType;