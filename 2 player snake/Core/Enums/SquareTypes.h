//
//  SquareTypes.h
//  2 player snake
//
//  Created by Kasnitskij_V on 12.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    HEAD = -1,
    BODY_PART = 0,
    AIM = 1,
    SNAKE_EXTENTION = 3,
    SNAKE_NARROW = 2,
    BARRIER = -2
} SquareTypesEnum;

@interface SquareTypes : NSObject {
    
}

@end
