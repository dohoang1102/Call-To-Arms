//
//  GameSoldier.m
//  Call To Arms
//
//  Created by Eddie Watson on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameSoldier.h"

@implementation GameSoldier

@synthesize crawlingAnimation;
@synthesize walkingAnimation;
@synthesize runningAnimation;


- (void)dealloc
{
    [crawlingAnimation release];
    [walkingAnimation release];
    [runningAnimation release];
    [super dealloc];
}

// Loads an animation from a given "plistName" with an animation "animationName"
- (CCAnimation *)loadPlistForAnimationWithName:(NSString *)animationName andPlistName:(NSString *)plistName
{
    CCAnimation *animationToReturn = nil;
    NSString *fullFileName = [NSString stringWithFormat:@"%@.plist", plistName];
    NSString *plistPath;
    
    // Get the path to open the plist file
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:fullFileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    }
    
    
    // Read the plist file
    NSDictionary *plistDictonary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    
    // If the plistDictionary was null then the file was not found.
    if (plistDictonary == nil)
    {
        CCLOG(@"Error reading plist: %@.plist", plistName);
        return nil;
    }
    
    
    // Get just the minidictionary for the requested animation
    NSDictionary *animationSettings = [plistDictonary objectForKey:animationName];
    if (animationSettings == nil)
    {
        CCLOG(@"Could not location animation with name: %@", animationName);
        return nil;
    }
    
    
    // Get the delay value for the animation
    float animationDelay = [[animationSettings objectForKey:@"delay"] floatValue];
    animationToReturn = [CCAnimation animation];
    [animationToReturn setDelay:animationDelay];
    
    
    // Add the frames to the animation
    NSString *animationFramePrefix = [animationSettings objectForKey:@"filenamePrefix"];
    NSString *animationFrames = [animationSettings objectForKey:@"animationFrames"];
    NSArray *animationFrameNumbers = [animationFrames componentsSeparatedByString:@","];
    
    for (NSString *frameNumber in animationFrameNumbers)
    {
        NSString *frameName = [NSString stringWithFormat:@"%@%@.png", animationFramePrefix, frameNumber];
        [animationToReturn addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName]];
    }
    
    return animationToReturn;

}

@end
