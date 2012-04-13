//
//  TempTankLevelLayer.m
//  Call To Arms
//
//  Created by Eddie Watson on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TempTankLevelLayer.h"

@implementation TempTankLevelLayer

/*+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	TempTankLevelLayer *layer = [TempTankLevelLayer node];
	
	// add layer as a child to scene
	[scene addChild:layer];
	
	// return the scene
	return scene;
}*/

// Move tank as a whole
- (void)moveTankHull:(CCSprite *)hull andTop:(CCSprite *)top
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    CCAction *moveHull = [CCMoveTo actionWithDuration:5.0f position:ccp(screenSize.width/2, screenSize.height - hull.boundingBox.size.height/2)];
    CCAction *moveTop = [CCMoveTo actionWithDuration:5.0f position:ccp(screenSize.width/2, screenSize.height - hull.boundingBox.size.height/2)];
    [hull runAction:moveHull];
    [top runAction:moveTop];
}

-(void)tankAnimation
{
    // Fun with tank sprite
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    if (tankHull == nil) {
        tankHull = [CCSprite spriteWithFile:@"Sherman Tank - Hull - Green.png"];
        [tankTop setPosition:ccp(screenSize.width/2, tankHull.boundingBox.size.height/2)];
        [self addChild:tankHull z:10 tag:TANK_HULL];
    }
    
    
    if (tankTop == nil) {
        tankTop = [CCSprite spriteWithFile:@"Sherman Tank - Turret - Green with outline.png"];
        [tankTop setPosition:ccp(screenSize.width/2, tankHull.boundingBox.size.height/2)];
        [self addChild:tankTop z:20 tag:TANK_TOP];
    }
    
    [tankHull setPosition:ccp(screenSize.width/2, tankHull.boundingBox.size.height/2)];
    [tankTop setPosition:ccp(screenSize.width/2, tankHull.boundingBox.size.height/2)];
    
    CCAction *rotate = [CCRotateBy actionWithDuration:5.0f angle:360.0f];
    [tankTop runAction:rotate];
    [self moveTankHull:tankHull andTop:tankTop];    
}


// Remove explosion
- (void)removeExplosion
{
    [self removeChild:explosion cleanup:YES];
}

// Explosion
- (void)makeExplosion
{
    explosion = [CCSprite spriteWithFile:@"Explosion.png"];
    [explosion setPosition:explosionLocation];
    [self addChild:explosion z:30 tag:EXPLOSION_TAG_VALUE];
    CCAction *action = [CCSequence actions:[CCMoveTo actionWithDuration:0.5f position:explosionLocation], [CCCallFunc actionWithTarget:self selector:@selector(removeExplosion)], nil];
    [explosion runAction:action];
}

// Move the tank to the users touch
-(void)moveTankToTouchLocation:(CGPoint)locationOfTouch
{
    
    //CCLOG(@"TOUCH LOC - X:%f Y:%f", locationOfTouch.x, locationOfTouch.y);
    //CCLOG(@"TANK HULL - X:%f Y:%f", tankHull.position.x, tankHull.position.y);
    CCLOG(@"\nCurrent tankRotation - %f", tankRotation);
    
    // Check which quadrant
    if ((locationOfTouch.x > tankHull.position.x) && (locationOfTouch.y > tankHull.position.y))
    {
        CCLOG(@"Upper right quadrant.");
        opposite = locationOfTouch.y - tankHull.position.y;
        adjacent = locationOfTouch.x - tankHull.position.x;
        degrees = atan(opposite/adjacent) * (180 / M_PI);
        CCLOG(@"Degrees - %f", degrees);
        if (tankRotation >= (180 - degrees))
        {
            rotation = ((360 - tankRotation) - degrees);
            tankRotation = (360 - degrees);
            CCLOG(@"Tank will rotate %f degrees to the right.", rotation);
        } else {
            rotation = -(tankRotation) - degrees;
            CCLOG(@"Tank will rotate %f degrees to the left.", -(rotation));
            tankRotation = (360 - degrees);
        }
    } else if ((locationOfTouch.x > tankHull.position.x) && (locationOfTouch.y < tankHull.position.y)) {
        CCLOG(@"Lower right quadrant.");
        opposite = locationOfTouch.y - tankHull.position.y;
        adjacent = locationOfTouch.x - tankHull.position.x;
        degrees = atan(opposite/adjacent) * (180 / M_PI);
        CCLOG(@"Degrees - %f", degrees);
        if (tankRotation >= (180 - degrees))
        {
            rotation = ((360 - tankRotation) - degrees);
            tankRotation = (360 - degrees);
            CCLOG(@"Tank will rotate %f degrees to the right.", rotation);
        } else {
            rotation = -(tankRotation) - degrees;
            CCLOG(@"Tank will rotate %f degrees to the left.", -(rotation));
            tankRotation = (360 - degrees);
        }
    } else if ((locationOfTouch.x < tankHull.position.x) && (locationOfTouch.y > tankHull.position.y)) {
        CCLOG(@"Upper left quadrant.");
        opposite = tankHull.position.x - locationOfTouch.x;
        adjacent = locationOfTouch.y - tankHull.position.y;
        degrees = atan(opposite/adjacent) * (180 / M_PI);
        CCLOG(@"Degrees - %f", degrees);
        if ( (tankRotation > 90 - degrees) && (tankRotation < 270 - degrees) )
        {
            rotation = ((270 - tankRotation) - degrees);
            tankRotation = (270 - degrees);
            CCLOG(@"1.Tank will rotate %f degrees to the right.", rotation);
        } else if (tankRotation > 270 - degrees) {
            rotation = -((tankRotation - 270) + degrees);
            CCLOG(@"2.Tank will rotate %f degrees to the left.", -(rotation));
            tankRotation = (270 - degrees);
        } else {
            rotation = -((360 + (tankRotation - 270)) + degrees);
            CCLOG(@"3.Tank will rotate %f degrees to the left.", -(rotation));
            tankRotation = (270 - degrees);
        }
    } else if ((locationOfTouch.x < tankHull.position.x) && (locationOfTouch.y < tankHull.position.y)) {
        CCLOG(@"Lower left quadrant.");
        opposite = tankHull.position.x - locationOfTouch.x;
        adjacent = tankHull.position.y - locationOfTouch.y;
        degrees = atan(opposite/adjacent) * (180 / M_PI);
        CCLOG(@"Degrees - %f", degrees);
        if ( (tankRotation > 90 + degrees) && (tankRotation < 270 + degrees) )
        {
            rotation = ((90 - tankRotation) + degrees);
            CCLOG(@"1.Tank will rotate %f degrees to the left.", -(rotation));
            tankRotation = (90 + degrees);
        } else if (tankRotation > 270 + degrees) {
            rotation = (360 - tankRotation) + 90 + degrees;
            CCLOG(@"2.Tank will rotate %f degrees to the right.", rotation);
            tankRotation = (90 + degrees);
        } else {
            rotation = (90 + degrees) - tankRotation;
            CCLOG(@"3.Tank will rotate %f degrees to the right.", rotation);
            tankRotation = (90 + degrees);
        }
    }
    
    // Tank rotation duration
    rotateDuration = (rotation / TANK_ROTATION_PER_SECOND);
    if (rotateDuration < 0)
        rotateDuration = -(rotateDuration);
    
    // Calculate distance and duration to move tank
    hypotenuse = sqrt((opposite * opposite) + (adjacent * adjacent));
    float moveDuration = (hypotenuse / TANK_MOVEMENT_PER_SECOND);
    
    moveToLocation = locationOfTouch;
    CCAction *actionH = [CCSequence actions:
                         [CCRotateBy actionWithDuration:rotateDuration angle:rotation],
                         [CCMoveTo actionWithDuration:0.5f 
                                             position:tankHull.position], 
                         [CCMoveTo actionWithDuration:moveDuration position:moveToLocation], nil];
    CCAction *actionT = [CCSequence actions:
                         [CCRotateBy actionWithDuration:rotateDuration angle:rotation], 
                         [CCMoveTo actionWithDuration:0.5f 
                                             position:tankHull.position], 
                         [CCMoveTo actionWithDuration:moveDuration position:moveToLocation], nil];
    [tankHull runAction:actionH];
    [tankTop runAction:actionT];
}


// Fire tank at touch location
- (void)fireTankToTouchLocation:(CGPoint)locationOfTouch
{
    // Check which quadrant
    if ((locationOfTouch.x > tankHull.position.x) && (locationOfTouch.y > tankHull.position.y))
    {
        CCLOG(@"Upper right quadrant.");
        opposite = locationOfTouch.y - tankHull.position.y;
        adjacent = locationOfTouch.x - tankHull.position.x;
        degrees = atan(opposite/adjacent) * (180 / M_PI);
        CCLOG(@"Angle: %f", degrees);
        degrees = 90 - degrees;
        CCLOG(@"Degrees to rotate to: %f", degrees);
        
    } else if ((locationOfTouch.x > tankHull.position.x) && (locationOfTouch.y < tankHull.position.y)) {
        CCLOG(@"Lower right quadrant.");
        opposite = locationOfTouch.y - tankHull.position.y;
        adjacent = locationOfTouch.x - tankHull.position.x;
        degrees = atan(opposite/adjacent) * (180 / M_PI);
        CCLOG(@"Angle: %f", degrees);
        degrees = 90 + abs(degrees);
        CCLOG(@"Degrees to rotate to: %f", degrees);
        
    } else if ((locationOfTouch.x < tankHull.position.x) && (locationOfTouch.y > tankHull.position.y)) {
        CCLOG(@"Upper left quadrant.");
        opposite = tankHull.position.x - locationOfTouch.x;
        adjacent = locationOfTouch.y - tankHull.position.y;
        degrees = atan(opposite/adjacent) * (180 / M_PI);
        CCLOG(@"Angle: %f", degrees);
        degrees = 360 - degrees;
        CCLOG(@"Degrees to rotate to: %f", degrees);
        
    } else if ((locationOfTouch.x < tankHull.position.x) && (locationOfTouch.y < tankHull.position.y)) {
        CCLOG(@"Lower left quadrant.");
        opposite = tankHull.position.x - locationOfTouch.x;
        adjacent = tankHull.position.y - locationOfTouch.y;
        degrees = atan(opposite/adjacent) * (180 / M_PI);
        CCLOG(@"Angle: %f", degrees);
        degrees = 180 + degrees;
        CCLOG(@"Degrees to rotate to: %f", degrees);
        
    }
    
    // Turret rotation duration
    rotation = abs(tankTop.rotation + degrees);
    CCLOG(@"Rotation: %f", rotation);
    if (rotation > 180)
    {
        rotation = rotation - 180;
        CCLOG(@"New rotation: %f", rotation);
    }
    rotateDuration = (rotation / TURRET_ROTATION_PER_SECOND);
    CCLOG(@"Rotation duration: %f", rotateDuration);
    
    explosionLocation = locationOfTouch;
    
    CCAction *action = [CCSequence actions:
                         [CCRotateTo actionWithDuration:rotateDuration angle:degrees], 
                         [CCMoveTo actionWithDuration:0.5f 
                                             position:tankHull.position], 
                         [CCCallFunc actionWithTarget:self selector:@selector(makeExplosion)], nil];
    [tankTop runAction:action];
}


// If touch occurs...
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CCLOG(@"Touch recognized");
    
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    // Convert touch location to a node space coordinate
    CGPoint touchLocation = [self convertTouchToNodeSpace:[touches anyObject]];
    
    // Check to see if two fingers are touching and if so, then quit (return to main menu)
    NSSet *allTouches = [event allTouches];
    int numberOfFingersTouching = [allTouches count];
    if (numberOfFingersTouching == 2)
    {
        [[GameManager sharedGameManager] runSceneWithId:kMainMenu];
    }
    
    // If fire was selected, fire at touch location.
    if (selection == kFireSelected)
    {
        CCLOG(@"tankTop number of running actions (for fire command) = %d", [tankTop numberOfRunningActions]);
        if ([tankTop numberOfRunningActions] == 0)
        {
            [self fireTankToTouchLocation:touchLocation];
            selection = kNoSelection;
            [self removeChildByTag:FIRE_LABEL_TAG_VALUE cleanup:YES];
        } else {
            CCLOG(@"Turret still running action.  Cannot fire.");
        }
    }
    
    // If move was selected, move to touch location.
    if (selection == kMoveSelected)
    {
        CCLOG(@"tankHull number of running actions = %d", [tankHull numberOfRunningActions]);
        if ([tankHull numberOfRunningActions] == 0) 
        {
            [self moveTankToTouchLocation:touchLocation];
            selection = kNoSelection;
            [self removeChildByTag:MOVE_LABEL_TAG_VALUE cleanup:YES];
        } else {
            if ((tankHull.position.x == moveToLocation.x) && (tankHull.position.y == moveToLocation.y))
            {
                [tankHull stopAllActions];
                [tankTop stopAllActions];
                [self moveTankToTouchLocation:touchLocation];
                selection = kNoSelection;
                [self removeChildByTag:MOVE_LABEL_TAG_VALUE cleanup:YES];
            } else {
                CCLOG(@"Tank is still moving.  Cannot move right now.");
            }
        }
    }
    
    // If tank is selected...
    if (selection == kTankSelected)
    {
        // Check if touch was one of the unit command buttons
        if (CGRectContainsPoint(moveButton.boundingBox, touchLocation))
        {
            // Move button was selected
            selection = kMoveSelected;
            [self removeChildByTag:SELECTION_TAG_VALUE cleanup:YES];
            [self removeChildByTag:MOVE_BUTTON_TAG_VALUE cleanup:YES];
            [self removeChildByTag:FIRE_BUTTON_TAG_VALUE cleanup:YES];
            CCLabelTTF *moveLabel = [CCLabelTTF labelWithString:@"Touch to move tank." fontName:@"Marker Felt" fontSize:30];
            CGSize screenSize = [CCDirector sharedDirector].winSize;
            [moveLabel setPosition:ccp(screenSize.width/2, screenSize.height - moveLabel.boundingBox.size.height)];
            [self addChild:moveLabel z:10 tag:MOVE_LABEL_TAG_VALUE];
        } else if (CGRectContainsPoint(fireButton.boundingBox, touchLocation)) {
            // Fire button was selected
            selection = kFireSelected;
            [self removeChildByTag:SELECTION_TAG_VALUE cleanup:YES];
            [self removeChildByTag:MOVE_BUTTON_TAG_VALUE cleanup:YES];
            [self removeChildByTag:FIRE_BUTTON_TAG_VALUE cleanup:YES];
            CCLabelTTF *fireLabel = [CCLabelTTF labelWithString:@"Touch to fire tank shell." fontName:@"Marker Felt" fontSize:30];
            CGSize screenSize = [CCDirector sharedDirector].winSize;
            [fireLabel setPosition:ccp(screenSize.width/2, screenSize.height - fireLabel.boundingBox.size.height)];
            [self addChild:fireLabel z:10 tag:FIRE_LABEL_TAG_VALUE];        
        } else if (!CGRectContainsPoint(tankHull.boundingBox, touchLocation)) {
            // Touch was outside of tank so deselect (remove selection indicator and command buttons)
            [self removeChildByTag:SELECTION_TAG_VALUE cleanup:YES];
            [self removeChildByTag:MOVE_BUTTON_TAG_VALUE cleanup:YES];
            [self removeChildByTag:FIRE_BUTTON_TAG_VALUE cleanup:YES];
            
            // Reset selection type to nothing selected 
            selection = kNoSelection;
        }
    }
    
    // If nothing selected...
    if (selection == kNoSelection)
    {
        // Check if touch was within the bounding box of the tank
        if (CGRectContainsPoint(tankHull.boundingBox, touchLocation))
        {
            // If it is show tank selected and display unit command buttons
            selectionIndicator = [CCSprite spriteWithFile:@"Sherman Tank - Selection Indicator.png"];
            [selectionIndicator setPosition:tankHull.position];
            [selectionIndicator setRotation:tankHull.rotation];
            [self addChild:selectionIndicator z:10 tag:SELECTION_TAG_VALUE];
            
            moveButton = [CCSprite spriteWithFile:@"Unit Command Option - Move.png"];
            fireButton = [CCSprite spriteWithFile:@"Unit Command Option - Fire.png"];
            if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) && (screenSize.width = 960.0f))
            {
                moveButton.scale = 2.5f;
                fireButton.scale = 2.5f;            
            }
             
            [moveButton setPosition:ccp(tankHull.position.x, tankHull.position.y - (tankHull.boundingBox.size.height / 2.0f) - 20)];
            [fireButton setPosition:ccp(moveButton.position.x, moveButton.position.y - moveButton.boundingBox.size.height)];
            [self addChild:moveButton z:100 tag:MOVE_BUTTON_TAG_VALUE];
            [self addChild:fireButton z:100 tag:FIRE_BUTTON_TAG_VALUE];
            
            // Set selection type to tank selected
            selection = kTankSelected;
        }
        
    }
    
}


-(void)addTank
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    tankHull = [CCSprite spriteWithFile:@"Sherman Tank - Hull - Green.png"];
    tankTop = [CCSprite spriteWithFile:@"Sherman Tank - Turret - Green.png"];
    [tankHull setPosition:ccp(screenSize.width/2, screenSize.height/2)];
    [tankTop setPosition:ccp(screenSize.width/2, screenSize.height/2)];
    [self addChild:tankHull z:20];
    [self addChild:tankTop z:21];
    
    CCLOG(@"tankRotation=270, tankHull.rotation=%f", tankHull.rotation);
    tankRotation = 270;
    
    // TEMP ADDING GERMAN PANZER SPRITE TO SCREEN
    germanHull = [CCSprite spriteWithFile:@"Panzer III Ausf L - Hull.png"];
    germanTurret = [CCSprite spriteWithFile:@"Panzer III Ausf L - Turret.png"];
    germanHull.position = ccp(screenSize.width * 0.25f, screenSize.height * 0.25f);
    germanTurret.position = ccp(screenSize.width * 0.25f, screenSize.height * 0.25f);
    germanTurret.rotation = 56.0f;
    [self addChild:germanHull z:10];
    [self addChild:germanTurret z:11];
    
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        // Enable touches
        self.isTouchEnabled = YES;
        //[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        
        // Set selection type to nothing selected
        selection = kNoSelection;
		
		// Create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Call to Arms" fontName:@"Marker Felt" fontSize:64];
        
		// Ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		// Position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: label];
        
        [self addTank];
        
        
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	[super dealloc];
}


@end
