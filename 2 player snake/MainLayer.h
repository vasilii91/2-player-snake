//
//  HelloWorldLayer.h
//  2 player snake
//
//  Created by Kasnitskij_V on 03.07.11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "OnePlayerScreen.h"
#import "TwoPlayerScreen.h"
#import "SettingsScreen.h"
#import "RecordsScreen.h"

// HelloWorldLayer
@interface MainLayer : CCLayer
{
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
