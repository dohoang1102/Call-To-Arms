//
//  GameManager.m
//  Call To Arms
//
//  Created by Eddie Watson on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameManager.h"

// Scenes to import
#import "MainMenuScene.h"
#import "OptionsMenuScene.h"
#import "TempTankLevelScene.h"
#import "TempMapLevelScene.h"
#import "TempSoldierLevelScene.h"

@implementation GameManager

static GameManager* _sharedGameManager = nil;   // Part of singelton creation

// Synthesize variables
@synthesize mapToPlay;
@synthesize managerSoundState;
@synthesize listOfSoundEffectFiles;
@synthesize soundEffectsState;


#pragma mark -
#pragma mark Singelton Creation
+ (GameManager*)sharedGameManager {
    @synchronized([GameManager class]) 
    {
        if(!_sharedGameManager) 
            [[self alloc] init]; 
        return _sharedGameManager;
    }
    return nil; 
}

+ (id)alloc 
{
    @synchronized ([GameManager class])                       
    {
        NSAssert(_sharedGameManager == nil, @"Attempted to allocated a second instance of the Game Manager singleton");
        _sharedGameManager = [super alloc];
        return _sharedGameManager;                                
    }
    return nil;  
}


#pragma mark -
#pragma mark Helper methods
// Change the scene type from a int-based enum to a string
- (NSString*)formatSceneTypeToString:(SceneTypes)sceneID {
    NSString *result = nil;
    switch(sceneID) {
        case kNoSceneUninitialized:
            result = @"kNoSceneUninitialized";
            break;
        case kGameIntro:
            result = @"kGameIntro";
            break;
        case kMainMenu:
            result = @"kMainMenu";
            break;
        case kMultiplayerGame:
            result = @"kMultiplayerGame";
            break;
        case kOptionsMenu:
            result = @"kOptionsMenu";
            break;
        case kPlayGameMenu:
            result = @"kPlayGameMenu";
            break;
        case kPlaySingleGame:
            result = @"kPlaySingleGame";
            break;
        case kPlayShortCampaign:
            result = @"kPlayShortCampaign";
            break;
        case kPlayGrandCampaign:
            result = @"kPlayGrandGampaign";
            break;
        case kSetupGame:
            result = @"kSetupGame";
            break;
            
        // TEMPORARY SCENES FOR DEVELOPMENT
        case kTempMapLevel:
            result = @"kTempMapLevel";
            break;
        case kTempSoldierLevel:
            result = @"kTempSoldierLevel";
            break;
        case kTempTankLevel:
            result = @"kTempTankLevel";
            break;
            
        default:
            [NSException raise:NSGenericException format:@"Unexpected SceneType."];
    }
    return result;
}


// Returns the dimension of the scene that is being used - PROBABLY DONT NEED THIS?
-(CGSize)getDimensionsOfCurrentScene
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CGSize levelSize;
    
    switch (currentScene)
    {
        case kGameIntro:
        case kMainMenu:
        case kMultiplayerGame:
        case kOptionsMenu:
        case kPlayGameMenu:
        case kPlaySingleGame:
        case kPlayShortCampaign:
        case kPlayGrandCampaign:
        case kSetupGame:
            
        case kTempMapLevel:
        case kTempSoldierLevel:
            levelSize = screenSize;
            break;
        case kTempTankLevel:
            levelSize = screenSize;
            break;
    
        default:
            CCLOG(@"Unknown Scene ID, returning default size");
            levelSize = screenSize;
            break;
    }
    
    return levelSize;
}

#pragma mark -
#pragma mark Audio
// Play the background track for the scene/menu
-(void)playBackgroundTrack:(NSString *)trackFileName
{
    
    // Wait to make sure the soundEngine is initialized
    if ((managerSoundState != kAudioManagerReady) && (managerSoundState != kAudioManagerFailed))
    {
        int waitCycles = 0;
        while (waitCycles < AUDIO_MAX_WAITTIME)
        {
            [NSThread sleepForTimeInterval:0.1f];
            if ((managerSoundState == kAudioManagerReady) || (managerSoundState == kAudioManagerFailed))
                break;
            
            waitCycles = waitCycles + 1;
        }
    }
    
    if (managerSoundState == kAudioManagerReady)
    {
        if ([soundEngine isBackgroundMusicPlaying])
        {
            [soundEngine stopBackgroundMusic];
        }
        [soundEngine preloadBackgroundMusic:trackFileName];
        [soundEngine playBackgroundMusic:trackFileName loop:YES];
    }
}


// Stop a sound effect while it is playing
-(void)stopSoundEffect:(ALuint)soundEffectID
{
    if (managerSoundState == kAudioManagerReady)
    {
        [soundEngine stopEffect:soundEffectID];
    }
}

// Play a sound effect
- (ALuint)playSoundEffect:(NSString *)soundEffectKey
{
    
    ALuint soundID = 0;
    if (managerSoundState == kAudioManagerReady)
    {
        NSNumber * isSFXLoaded = [soundEffectsState objectForKey:soundEffectKey];
        if ([isSFXLoaded boolValue] == SFX_LOADED)
        {
            soundID = [soundEngine playEffect:[listOfSoundEffectFiles objectForKey:soundEffectKey]];
        } else {
            CCLOG(@"GameMgr: SoundEffect %@ is not loaded.", soundEffectKey);
        }
    } else {
        CCLOG(@"GameMgr: Sound Manager is not ready, cannot play %@", soundEffectKey);
    }
    
    return soundID;
}

// Gets the list of sound effects for the scene
- (NSDictionary *)getSoundEffectsListForSceneWithID:(SceneTypes)sceneID
{
    NSString *fullFileName = @"SoundEffects.plist";
    NSString *plistPath;
    
    // 1. Get the path to the plist file
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:fullFileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        plistPath = [[NSBundle mainBundle] pathForResource:@"SoundEffects" ofType:@"plist"];
    }
    
    // 2. Read in the plist file
    NSDictionary *plistDictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    // 3. If the plistdictionary was null, the file was not found
    if (plistDictionary == nil)
    {
        CCLOG(@"Error reading SoundEffects.plist");
        return nil; // No plist directory or file found
    }
    
    // 4. If the list of soundEffectFiles is empty, load it
    if ((listOfSoundEffectFiles == nil) || ([listOfSoundEffectFiles count] < 1))
    {
        [self setListOfSoundEffectFiles:[[NSMutableDictionary alloc] init]];
        for (NSString *sceneSoundDictionary in plistDictionary)
        {
            [listOfSoundEffectFiles addEntriesFromDictionary:[plistDictionary objectForKey:sceneSoundDictionary]];
        }
        CCLOG(@"Number of SFX filenames: %d", [listOfSoundEffectFiles count]);
    }
    
    // 5. Load the list of sound effects state, mark them as unloaded
    if ((soundEffectsState == nil) || ([soundEffectsState count] < 1))
    {
        [self setSoundEffectsState:[[NSMutableDictionary alloc] init]];
        for (NSString *SoundEffectsKey in listOfSoundEffectFiles)
        {
            [soundEffectsState setObject:[NSNumber numberWithBool:SFX_NOTLOADED] forKey:SoundEffectsKey];
        }
    }
    
    // 6. Return just the mini SFX list for this scene
    NSString *sceneIDName = [self formatSceneTypeToString:sceneID];
    NSDictionary *soundEffectsList = [plistDictionary objectForKey:sceneIDName];
    
    return soundEffectsList;
}

// Load audio files for the scene
- (void)loadAudioForSceneWithID:(NSNumber *)sceneIDNumber
{
    //NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    SceneTypes sceneID = (SceneTypes)[sceneIDNumber intValue];
    
    if (managerSoundState == kAudioManagerInitializing)
    {
        int waitCycles = 0;
        while (waitCycles < AUDIO_MAX_WAITTIME)
        {
            [NSThread sleepForTimeInterval:0.1f];
            if ((managerSoundState == kAudioManagerReady) || (managerSoundState == kAudioManagerFailed))
            {
                break;
            }
            waitCycles = waitCycles + 1;
        }
    }
    
    if (managerSoundState == kAudioManagerFailed)
    {
        return; // Nothing to load
    }
    
    NSDictionary *soundEffectsToLoad = [self getSoundEffectsListForSceneWithID:sceneID];
    if (soundEffectsToLoad == nil)
    {
        CCLOG(@"Error reading SoundEffects.plist");
        return;
    }
    
    // Get all entries and preload
    for (NSString *keyString in soundEffectsToLoad)
    {
        CCLOG(@"\nLoading Audio Key:%@ File:%@", keyString, [soundEffectsToLoad objectForKey:keyString]);
        [soundEngine preloadEffect:[soundEffectsToLoad objectForKey:keyString]];
        [soundEffectsState setObject:[NSNumber numberWithBool:SFX_LOADED] forKey:keyString];
    }
    
    //[pool autorelease];
}

// Unload the audio
- (void)unloadAudioForSceneWithID:(NSNumber *)sceneIDNumber
{
    //NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    SceneTypes sceneID = (SceneTypes)[sceneIDNumber intValue];
    if (sceneID == kNoSceneUninitialized)
    {
        return; // Nothing to unload
    }
    
    NSDictionary *soundEffectsToUnload = [self getSoundEffectsListForSceneWithID:sceneID];
    if (soundEffectsToUnload == nil)
    {
        CCLOG(@"Error reading SoundEffects.plist");
        return;
    }
    
    if (managerSoundState == kAudioManagerReady)
    {
        // Get all of the entries and unload
        for (NSString *keyString in soundEffectsToUnload)
        {
            [soundEffectsState setObject:[NSNumber numberWithBool:SFX_NOTLOADED] forKey:keyString];
            [soundEngine unloadEffect:keyString];
            CCLOG(@"\nUnloading Audio Key:%@ File:%@", keyString, [soundEffectsToUnload objectForKey:keyString]);
        }
    }
    
    //[pool autorelease];
}

// Asynchronously initialize the sound engine
- (void)initAudioAsync
{
    // Initializes the audio engine asunchronously
    managerSoundState = kAudioManagerInitializing;
    [CDSoundEngine setMixerSampleRate:CD_SAMPLE_RATE_MID];
    
    // Init audio manager async so it can take a few seconds.  The FXPlusMusicIfNoOtherAudio will check if the user is playing music and disable background music playback if that is the case
    [CDAudioManager initAsynchronously:kAMM_FxPlusMusicIfNoOtherAudio];
    
    // Wait for the audio manager to initialize
    while ([CDAudioManager sharedManagerState] != kAMStateInitialised)
    {
        [NSThread sleepForTimeInterval:0.1];
    }
    
    // At this point the CocosDenshion should be initialized.  Grab the CDAudioManager and check the state
    CDAudioManager *audioManager = [CDAudioManager sharedManager];
    if (audioManager.soundEngine == nil || audioManager.soundEngine.functioning == NO)
    {
        CCLOG(@"CocosDenshion failed to init, no audio will play");
        managerSoundState = kAudioManagerFailed;
    } else {
        [audioManager setResignBehavior:kAMRBStopPlay autoHandle:YES];
        soundEngine = [SimpleAudioEngine sharedEngine];
        managerSoundState = kAudioManagerReady;
        CCLOG(@"CocosDenshion is ready");
    }
}

// Setup the audio engine
- (void)setupAudioEngine
{
    if (hasAudioBeenInitialized == YES)
    {
        return;
    } else {
        hasAudioBeenInitialized = YES;
        NSOperationQueue *queue = [[NSOperationQueue new] autorelease];
        NSInvocationOperation *asyncSetupOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(initAudioAsync) object:nil];
        [queue addOperation:asyncSetupOperation];
        [asyncSetupOperation autorelease];
    }
}


#pragma mark -
#pragma mark Run Scene
// Runs a scene given a sceneID passed
- (void)runSceneWithId:(SceneTypes)sceneID 
{
    SceneTypes oldScene = currentScene;
    currentScene = sceneID;
    
    id sceneToRun = nil;
    switch (sceneID) {
        case kGameIntro:
            // Placeholder
            break;
        case kMainMenu:
            sceneToRun = [MainMenuScene node];
            break;
            
        // Placeholders
        case kMultiplayerGame:
            break;
        case kOptionsMenu:
            sceneToRun = [OptionsMenuScene node];
            break;
        case kPlayGameMenu:
            break;
        case kPlaySingleGame:
            break;
        case kPlayShortCampaign:
            break;
        case kPlayGrandCampaign:
            break;
        case kSetupGame:
            break;
            
        // TEMPORARY
        case kTempMapLevel:
            sceneToRun = [TempMapLevelScene node];
            break;
        case kTempSoldierLevel:
            sceneToRun = [TempSoldierLevelScene node];
            break;
        case kTempTankLevel:
            sceneToRun = [TempTankLevelScene node];
            break;
            
        default:
            CCLOG(@"Unknown ID, cannot switch scenes");
            return;
            break;
    }
    if (sceneToRun == nil) {
        // Revert back, since no new scene was found
        currentScene = oldScene;
        return;
    }
    
    // AUDIO LOAD (TEMP DISABLED)
    // Load audio for new scene based on sceneID
    //[self performSelectorInBackground:@selector(loadAudioForSceneWithID:) withObject:[NSNumber numberWithInt:currentScene]];
    
    // Menu Scenes have a value of < 100
    // SCALLING USING A SINGLE IMAGE: Not needed
    /*
    if (sceneID < 100) {
        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) { 
            CGSize screenSize = [CCDirector sharedDirector].winSizeInPixels; 
            if (sceneID != kGameIntro)
            {
                if (screenSize.width == 960.0f) {
                    // iPhone 4 Retina
                    [sceneToRun setScaleX:0.9375f];
                    [sceneToRun setScaleY:0.8333f];
                    CCLOG(@"GameMgr:Scaling for iPhone 4 (retina)");
                } else {
                    [sceneToRun setScaleX:0.4688f];
                    [sceneToRun setScaleY:0.4166f];
                    CCLOG(@"GameMgr:Scaling for iPhone 3GS or older (non-retina)");
                }
            }
        }
    }*/
    
    // Checks the state of the CCDirector playing a scene and runs the appropriate run/replace method for new scene
    if ([[CCDirector sharedDirector] runningScene] == nil) 
    {
        [[CCDirector sharedDirector] runWithScene:sceneToRun];
        
    } else {
        [[CCDirector sharedDirector] replaceScene:sceneToRun];
    }    
    
    
    // AUDIO UNLOAD (TEMP DISABLED)
    //[self performSelectorInBackground:@selector(unloadAudioForSceneWithID:) withObject:[NSNumber numberWithInt:oldScene]];
    
    currentScene = sceneID;
}


#pragma mark -
#pragma mark Init Method
// Main init method - setups variables
- (id)init {                                                        
    self = [super init];
    if (self != nil) {
        // Game Manager initialized
        CCLOG(@"Game Manager Singleton, init");
        
        // Set variables to initialized states
        currentScene = kNoSceneUninitialized;
        mapToPlay = kNoMapSelected;
        hasAudioBeenInitialized = NO;
        soundEngine = nil;
        managerSoundState = kAudioManagerUnitialized;
    }
    return self;
}

@end
