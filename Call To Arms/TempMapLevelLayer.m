//
//  TempMapLevelLayer.m
//  Call To Arms
//
//  Created by Eddie Watson on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TempMapLevelLayer.h"

@implementation TempMapLevelLayer

- (void)dealloc
{
    [super dealloc];
}

- (void)returnToMenu
{
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [[GameManager sharedGameManager] runSceneWithId:kMainMenu];
}

- (void)addAmericanTank
{
    // TEMP ADD AMERICAN TANK (Non-selectable)
    americanTankHull = [CCSprite spriteWithFile:@"Sherman Tank - Hull - Green.png"];
    americanTankTurret = [CCSprite spriteWithFile:@"Sherman Tank - Turret - Green.png"];
    
    [americanTankHull setPosition:ccp(mapSize.width * 0.25f + 100, mapSize.height * 0.25f)];
    [americanTankTurret setPosition:ccp(mapSize.width * 0.25f + 100, mapSize.height * 0.25f)];
    
    americanTankHull.scale *= tankScaleFactor;
    americanTankTurret.scale *= tankScaleFactor;
    
    americanTankHull.rotation = 45.0f;
    americanTankTurret.rotation = 45.0f;
    
    [self addChild:americanTankHull z:10];
    [self addChild:americanTankTurret z:11];
    
    CCAction *moveActionAH = [CCMoveTo actionWithDuration:30.0f position:ccp(mapSize.width * 0.75f + 100, mapSize.height * 0.75f)];
    CCAction *moveActionAT = [CCMoveTo actionWithDuration:30.0f position:ccp(mapSize.width * 0.75f + 100, mapSize.height * 0.75f)];
    [americanTankHull runAction:moveActionAH];
    [americanTankTurret runAction:moveActionAT];
}

- (void)addGermanTank
{
    // TEMP ADD GERMAN TANK (Selectable)
    germanTankHull = [CCSprite spriteWithFile:@"Panzer III Ausf L - Hull.png"];
    germanTankTurret = [CCSprite spriteWithFile:@"Panzer III Ausf L - Turret.png"];
    germanTankSelectIndicator = [CCSprite spriteWithFile:@"Panzer III Ausf L - Selection Indicator.png"];
    
    [germanTankHull setPosition:ccp(mapSize.width * 0.25f, mapSize.height * 0.25f)];
    [germanTankTurret setPosition:ccp(mapSize.width * 0.25f, mapSize.height * 0.25f)];
    [germanTankSelectIndicator setPosition:ccp(mapSize.width * 0.25f, mapSize.height * 0.25f)];
    
    germanTankHull.scale *= tankScaleFactor;
    germanTankTurret.scale *= tankScaleFactor;
    germanTankSelectIndicator.scale *= tankScaleFactor;
    
    germanTankHull.rotation = 45.0f;
    germanTankTurret.rotation = 45.0f;
    germanTankSelectIndicator.rotation = 45.0f;
    
    germanTankSelectIndicator.visible = NO;
    
    [self addChild:germanTankHull z:10];
    [self addChild:germanTankTurret z:11];
    [self addChild:germanTankSelectIndicator z:10];
    
    CCAction *moveActionH = [CCMoveTo actionWithDuration:20.0f position:ccp(mapSize.width * 0.75f, mapSize.height * 0.75f)];
    CCLOG(@"Move to... %f, %f", mapSize.width *0.75f, mapSize.height * 0.75f);
    CCAction *moveActionT = [CCMoveTo actionWithDuration:20.0f position:ccp(mapSize.width * 0.75f, mapSize.height * 0.75f)];
    CCAction *moveActionI = [CCMoveTo actionWithDuration:20.0f position:ccp(mapSize.width * 0.75f, mapSize.height * 0.75f)];
    [germanTankHull runAction:moveActionH];
    [germanTankTurret runAction:moveActionT];
    [germanTankSelectIndicator runAction:moveActionI];
}

- (void)loadMapInToView
{
    // Reduce pixel format since no alpha channel needed for BGM
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];
    
    if ([GameManager sharedGameManager].mapToPlay == kMapChemin)
    {
        bgmBL = [CCSprite spriteWithFile:@"Normandy - Omaha - Chemin BL.png"];
        bgmBL.scale = scaleFactor;
        bgmBL.anchorPoint = ccp(0,0);
        [self addChild:bgmBL];
        
        bgmBR = [CCSprite spriteWithFile:@"Normandy - Omaha - Chemin BR.png"];
        bgmBR.scale = scaleFactor;
        bgmBR.anchorPoint = ccp(0,0);
        [bgmBR setPosition:ccp(bgmBL.contentSize.width - 2,0)];
        [self addChild:bgmBR];
        
        bgmTL = [CCSprite spriteWithFile:@"Normandy - Omaha - Chemin TL.png"];
        bgmTL.scale = scaleFactor;
        bgmTL.anchorPoint = ccp(0,0);
        bgmTL.position = ccp(0,bgmBL.contentSize.height - 2);
        [self addChild:bgmTL];
        
        bgmTR = [CCSprite spriteWithFile:@"Normandy - Omaha - Chemin TR.png"];
        bgmTR.scale = scaleFactor;
        bgmTR.anchorPoint = ccp(0,0);
        bgmTR.position = ccp(bgmTL.contentSize.width - 2,bgmBR.contentSize.height - 2);
        [self addChild:bgmTR];
        
        mapSize = CGSizeMake((bgmBL.contentSize.width + bgmBR.contentSize.width) * scaleFactor, (bgmBR.contentSize.height + bgmTR.contentSize.height) * scaleFactor);
    } else if ([GameManager sharedGameManager].mapToPlay == kMapCharlie) {
        bgmBL = [CCSprite spriteWithFile:@"Normandy - Omaha - Charlie.png"];
        bgmBL.scale = scaleFactor;
        bgmBL.anchorPoint = ccp(0, 0);
        bgmBL.position = ccp(0, 0);
        [self addChild:bgmBL];
        
        mapSize = CGSizeMake(bgmBL.contentSize.width * scaleFactor, bgmBL.contentSize.height * scaleFactor);
    } else if ([GameManager sharedGameManager].mapToPlay == kMapDogW) {
        bgmBL = [CCSprite spriteWithFile:@"Normandy - Omaha - DogW BL.png"];
        bgmBL.scale = scaleFactor;
        bgmBL.anchorPoint = ccp(0, 0);
        bgmBL.position = ccp(0, 0);
        [self addChild:bgmBL];
        
        mapSize = CGSizeMake(bgmBL.contentSize.width * scaleFactor, bgmBL.contentSize.height * scaleFactor);
    } else {
        CCLOG(@"Unknown map to play.  Returning to main menu!");
        [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
        [[GameManager sharedGameManager] runSceneWithId:kMainMenu];
    }
    
    
    //mapSize = CGSizeMake(mapBackground.contentSize.width * scaleFactor, mapBackground.contentSize.height * scaleFactor);
    
    // Return to default pixel format
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
}

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        // Temp self-set variables
        scaleFactor = 1.0f;
        tankScaleFactor = scaleFactor / 2.0f;
        
        //CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        [self loadMapInToView];
        
        [self addGermanTank];
        
        [self addAmericanTank];
        
        // Add quit button
        quitButton = [CCSprite spriteWithFile:@"Exit Quit Power Icon.png"];
        [quitButton setAnchorPoint:ccp(0,0)];
        quitButton.position = ccp(0,0);
        quitButton.scale = 0.5f;
        [self addChild:quitButton z:100];
        
        // Touch recognition (Switch to self.isTouchEnable = YES???)
        //self.isTouchEnabled = YES;
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        
    }
    
    return self;
}

/*
- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    // Convert touch location to a node space coordinate
    touchLocation = [self convertTouchToNodeSpace:[touches anyObject]];
    
    // Check to see if two fingers are touching and if so, then quit (return to main menu)
    NSSet *allTouches = [event allTouches];
    int numberOfFingersTouching = [allTouches count];
    if (numberOfFingersTouching == 2)
    {
        [[GameManager sharedGameManager] runSceneWithId:kMainMenu];
    }
    
    // Check to see if touch location was within the bounding box of the german tank
    // If it is and tank IS NOT selected, select it.
    // If it isn't and the tank IS selected, deselect it.
    if (!germanTankSelectIndicator.visible)
    {
        if (CGRectContainsPoint(germanTankHull.boundingBox, touchLocation))
            germanTankSelectIndicator.visible = YES;
    } else if (germanTankSelectIndicator.visible) {
        if (!CGRectContainsPoint(germanTankHull.boundingBox, touchLocation))
            germanTankSelectIndicator.visible = NO;
    }
} */


// Recognize that a touch has began
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    // Convert touch location to a node space coordinate
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    // First check if quitButton is touched, and if so, quit.
    if (CGRectContainsPoint(quitButton.boundingBox, touchLocation))
        [self returnToMenu];
    
    // Check to see if touch location was within the bounding box of the german tank
    // If it is and tank IS NOT selected, select it.
    // If it isn't and the tank IS selected, deselect it.
    if (!germanTankSelectIndicator.visible)
    {
        if (CGRectContainsPoint(germanTankHull.boundingBox, touchLocation))
            germanTankSelectIndicator.visible = YES;
    } else if (germanTankSelectIndicator.visible) {
        if (!CGRectContainsPoint(germanTankHull.boundingBox, touchLocation))
            germanTankSelectIndicator.visible = NO;
    }
    
    return TRUE;
}

// Check and ensure that the scrolling does not surpass the size of the map
- (CGPoint)boundLayerPosition:(CGPoint)newPos
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    CGPoint retval = newPos;
    retval.x = MIN(retval.x, 0);
    retval.x = MAX(retval.x, -mapSize.width * scaleFactor + screenSize.width);
    retval.y = MIN(retval.y, 0);
    retval.y = MAX(retval.y, -mapSize.height * scaleFactor + screenSize.height);
    
    return retval;
}

// Pan the view based on the difference in touch locations (aka translation)
- (void)panForTranslation:(CGPoint)translation
{
    CGPoint newPos = ccpAdd(self.position, translation);
    self.position = [self boundLayerPosition:newPos];
}


// Check for movement of the touch event
- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);
    [self panForTranslation:translation];
}

/*
// Check for touch movment
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Save old touch location
    CGPoint oldTouchLocation = touchLocation;
    
    // Get new touch location
    touchLocation = [self convertTouchToNodeSpace:[touches anyObject]];
    
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);
    [self panForTranslation:translation];
}*/

@end
