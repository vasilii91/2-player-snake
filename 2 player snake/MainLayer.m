//
//  HelloWorldLayer.m
//  2 player snake
//
//  Created by Kasnitskij_V on 03.07.11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// Import the interfaces
#import "MainLayer.h"

static int FONT_SIZE = 32;

// HelloWorldLayer implementation
@implementation MainLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainLayer *layer = [MainLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        [CCMenuItemFont setFontSize: FONT_SIZE];
        
        // спрашиваем у системы размер экрана
        CGSize winSize = [[CCDirector sharedDirector] winSize];
		
        CCMenuItem *onePlayerButton = [CCMenuItemFont itemFromString:@"1 player" target:self selector:@selector(onePlayerFunction:)];
        CCMenuItem *twoPlayerButton = [CCMenuItemFont itemFromString:@"2 player" target:self selector:@selector(twoPlayerFunction:)];
        CCMenuItem *settingButton = [CCMenuItemFont itemFromString:@"Settings" target:self selector:@selector(settingsFunction:)];
        CCMenuItem *recordsButton = [CCMenuItemFont itemFromString:@"Records" target:self selector:@selector(recordsFunction:)];

        onePlayerButton.position = ccp(winSize.width / 2, winSize.height - FONT_SIZE);
		twoPlayerButton.position = ccp(winSize.width / 2, winSize.height - 2 * FONT_SIZE);
        settingButton.position = ccp(winSize.width / 2, winSize.height - 3 * FONT_SIZE);
        recordsButton.position = ccp(winSize.width / 2, winSize.height - 4 * FONT_SIZE);
        
        CCMenu *mainMenu = [CCMenu menuWithItems: onePlayerButton, twoPlayerButton, settingButton, recordsButton, nil];
        mainMenu.position = CGPointZero;
        
        CCMenuItemImage *backgroundImage = [CCMenuItemImage itemFromNormalImage:@"background04.jpg" selectedImage:@"background04.jpg"];
        backgroundImage.position = ccp(240,160);
        [self addChild:backgroundImage];
        
		// add the label as a child to this Layer
		[self addChild: mainMenu];
	}
	return self;
}

- (void)onePlayerFunction:(id)sender 
{
    [[CCDirector sharedDirector] replaceScene: [CCTransitionJumpZoom transitionWithDuration:1.5f scene: [OnePlayerScreen scene]]];
}

- (void)twoPlayerFunction:(id)sender 
{
    [[CCDirector sharedDirector] replaceScene: [CCTransitionJumpZoom transitionWithDuration:1.5f scene: [TwoPlayerScreen scene]]];
}

- (void)settingsFunction:(id)sender 
{
    [[CCDirector sharedDirector] replaceScene: [CCTransitionSplitCols transitionWithDuration:1 scene: [SettingsScreen scene]]];
}

- (void)recordsFunction:(id)sender 
{
    [[CCDirector sharedDirector] replaceScene: [CCTransitionRotoZoom transitionWithDuration:1.5f scene: [RecordsScreen scene]]];
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
