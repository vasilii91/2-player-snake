//
//  RecordsScreen.m
//  2 player snake
//
//  Created by Kasnitskij_V on 03.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RecordsScreen.h"


@implementation RecordsScreen

+(id) scene
{
    CCNode *scene = [CCNode node];
    RecordsScreen *layer = [RecordsScreen node];
    [scene addChild: layer];
    
    return scene;
}

-(id) init 
{
    if ((self = [super initWithColor: ccc4(255, 200, 200, 155)])) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        CCLabelTTF *title = [CCLabelTTF labelWithString:@"Records" fontName:@"Arial" fontSize:64];
        title.position = ccp(winSize.width/2, winSize.height - title.contentSize.height/2);
        
        CCMenuItem *backButton = [CCMenuItemImage itemFromNormalImage:@"button_cancel.png" selectedImage:@"button_cancel.png" target:self selector:@selector(backFunction:)];
        [backButton setScale:BUTTON_SCALE];
        backButton.position = ccp(-winSize.width / 2 + backButton.contentSize.width / 4 + 5, winSize.height / 2 - backButton.contentSize.height / 4);
        
        CCMenu *mainMenu = [CCMenu menuWithItems:backButton, nil];
        
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
