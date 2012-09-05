//
//  Square.m
//  2 player snake
//
//  Created by Kasnitskij_V on 04.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Square.h"


@implementation Square

+(Square*)square:(SquareTypesEnum)squareType
{
    Square *newSquare = nil;
    switch (squareType) {
        case HEAD:
            newSquare = [Square spriteWithFile:@"Square0.png"];
            break;
        case BODY_PART:
            newSquare = [Square spriteWithFile:@"Square1.png"];
            break;
        case AIM:
            newSquare = [Square spriteWithFile:@"Square0.png"];
            break;
        case SNAKE_EXTENTION:
            newSquare = [Square spriteWithFile:@"Square2.png"];
            break;
        case SNAKE_NARROW:
            newSquare = [Square spriteWithFile:@"Square4.png"];
            break;
        case BARRIER:
            newSquare = [Square spriteWithFile:@"Square7.png"];
            break;
        default:
            break;
    }
    
    [newSquare setCurrentSquareType:squareType];
    
    return newSquare;
}

-(void)setCurrentSquareType:(SquareTypesEnum)type
{
    currentSquareType = type;
}

-(CGSize)size
{
    return [self contentSize];
}

-(int)height
{
    return [self contentSize].height;
}

-(int)width
{
    return [self contentSize].width;
}

@end