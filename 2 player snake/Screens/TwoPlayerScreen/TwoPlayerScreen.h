//
//  TwoPlayerScreen.h
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

@interface TwoPlayerScreen : CCLayerColor {
    Snake *snake;
    Grid *grid;
    int interval;
    int currentSpeed;
    BOOL headIsLastObjectOfArray;
}

+(id) scene;
-(void)drawSquareOnScreen:(Square*)square;
-(void)changeDirection:(BOOL)isOnAim;

@end
