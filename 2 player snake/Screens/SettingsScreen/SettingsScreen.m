//
//  SettingsScreen.m
//  2 player snake
//
//  Created by Kasnitskij_V on 03.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsScreen.h"


@implementation SettingsScreen

+ (id) scene 
{
    CCScene *scene = [CCScene node];
    SettingsScreen *layer = [SettingsScreen node];
    [scene addChild: layer];

    return scene;
}

-(id) init 
{
    if ((self = [super initWithColor: ccc4(255, 100, 200, 255)])) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        CCLabelTTF *title = [CCLabelTTF labelWithString:@"Settings" fontName:@"Arial" fontSize:64];
        title.position = ccp(winSize.width/2, winSize.height - title.contentSize.height/2);
        
        CCMenuItem *backButton = [CCMenuItemImage itemFromNormalImage:@"button_cancel.png" selectedImage:@"button_cancel.png" target:self selector:@selector(backFunction:)];
        [backButton setScale:BUTTON_SCALE];
        backButton.position = ccp(-winSize.width / 2 + backButton.contentSize.width / 4 + 5, winSize.height / 2 - backButton.contentSize.height / 4);
        
        CCMenu *mainMenu = [CCMenu menuWithItems:backButton, nil];

        for (int i = 0; i < 5; i++) {
            CCMenuItem *menuItem = [CCMenuItemFont itemFromString:@"asdfasdfasdf"];
            [menuItem setScale:0.9f];
            [menuItem setPosition:ccp(-winSize.width / 2 + [menuItem contentSize].width / 2, winSize.height / 4 - i * 25)];
            [mainMenu addChild:menuItem];
        }
        [self addChild:title];
        [self addChild:mainMenu];
    }
    
    return self;
}

- (void)backFunction:(id)sender 
{
    [[CCDirector sharedDirector] replaceScene: [CCTransitionSlideInL transitionWithDuration:1 scene: [MainLayer scene]]];
}

@end
