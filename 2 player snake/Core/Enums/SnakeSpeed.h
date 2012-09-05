//
//  SnakeSpeed.h
//  2 player snake
//
//  Created by Kasnitskij_V on 06.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    // enum = lenght of interval
    SPEED_X1 = 1090,
    SPEED_X2 = 1000,
    SPEED_X3 = 910,
    SPEED_X4 = 820,
    SPEED_X5 = 730,
    SPEED_X6 = 640,
    SPEED_X7 = 550,
    SPEED_X8 = 460,
    SPEED_X9 = 380,
    SPEED_X10 = 290,
    SPEED_X11 = 200,
    SPEED_X12 = 110,
    SPEED_X13 = 100,
    SPEED_X14 = 90,
    SPEED_X15 = 70
} SnakeSpeedEnum;

@interface SnakeSpeed : NSObject {
    
}

-(int)getTimeToSpeed;

@end
