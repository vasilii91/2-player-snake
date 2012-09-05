//
//  OnePlayerScreen.h
//  2 player snake
//
//  Created by Kasnitskij_V on 03.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MainLayer.h"
#import "Snake.h"
#import "Square.h"
#import "Directions.h"
#import "SnakeSpeed.h"
#import "Grid.h"
#import "SquareTypes.h"
#import "Constants.h"

@interface OnePlayerScreen : CCLayerColor {
    Snake *snake;
    Grid *grid;
    int interval;
    int delay;
    int currentSpeed;
    BOOL headIsLastObjectOfArray;
    int countOfClickWhenGameOver;
    
    // it's variables to delay plus-points on the screen
    BOOL keepPointsOnScreen;
    BOOL showOnce;
    
    CCMenuItemFont *points;
    CCMenuItemFont *plusSomePoints;
    CCMenuItemFont *gameOver;
    CCMenuItemImage *transparentBackground;
    CCSprite *aimSprite;
}
+(id) scene;
-(void)drawSquareOnScreen:(Square*)square;
-(void)changeDirection:(BOOL)isOnAim;
-(void)goToMainScreen;
-(void)showAimWithHelpAnimation:(CGPoint)position;

@end
