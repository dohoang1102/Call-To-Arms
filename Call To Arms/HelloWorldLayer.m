//
//  HelloWorldLayer.m
//  Call To Arms
//
//  Created by Eddie Watson on 3/7/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "Constants.h"
#import "math.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// TEMP FUN
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
    
    // Turret rotation duration
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


// If touch occurs...
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[self tankAnimation];
    //CGPoint touchLocation = [touches locationInView:[touches view]];
    //touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    //touchLocation = [self convertToNodeSpace:touchLocation];
    
    CGPoint touchLocation = [self convertTouchToNodeSpace:[touches anyObject]];
    
    CCLOG(@"tankHull number of running actions = %d", [tankHull numberOfRunningActions]);
    if ([tankHull numberOfRunningActions] == 0) 
    {
        [self moveTankToTouchLocation:touchLocation];
    } else {
        if ((tankHull.position.x == moveToLocation.x) && (tankHull.position.y == moveToLocation.y))
        {
            [tankHull stopAllActions];
            [tankTop stopAllActions];
            [self moveTankToTouchLocation:touchLocation];
        }
    }
}
    

-(void)addTank
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    tankHull = [CCSprite spriteWithFile:@"Sherman Tank - Hull - Green.png"];
    tankTop = [CCSprite spriteWithFile:@"Sherman Tank - Turret - Green with outline.png"];
    [tankHull setPosition:ccp(screenSize.width/2, screenSize.height/2)];
    [tankTop setPosition:ccp(screenSize.width/2, screenSize.height/2)];
    [self addChild:tankHull];
    [self addChild:tankTop];
    
    tankRotation = 270;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        self.isTouchEnabled = YES;
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Call to Arms" fontName:@"Marker Felt" fontSize:64];

		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
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
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
