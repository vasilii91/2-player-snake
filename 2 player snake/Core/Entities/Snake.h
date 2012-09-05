//
//  Snake.h
//  2 player snake
//
//  Created by Kasnitskij_V on 04.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Square.h"
#import "Directions.h"
#import "SnakeSpeed.h"
#import "Cell.h"
#import "Grid.h"
#import "SquareTypes.h"

@interface Snake: NSObject{
    NSMutableArray *snake;
    NSMutableArray *remainsOfTheSnake;
    NSMutableArray *barriers;
    DirectionsEnum currentDirection;
    SnakeSpeedEnum snakeSpeed;
    @public
        Square *aim;
        int points;
}
+(id)alloc;
-(id)init;
-(NSMutableArray*)snake;
-(NSMutableArray*)remainsOfTheSnake;
-(void)deleteRemainsOfTheSnake;
-(void)dequeue;
-(id)dequeueFromEnd;
-(void)enqueue:(id)obj;
-(void)enqueueToStart:(id)obj;
-(id)lastObject;
-(id)objectAtIndex:(NSUInteger)index;
-(DirectionsEnum)currentDirection;
-(void)setCurrentDirection:(DirectionsEnum)direction;
-(SnakeSpeedEnum)snakeSpeed;
-(void)setSnakeSpeed:(SnakeSpeedEnum)speed;
-(CGPoint)headPosition;
-(void)switchCurrentSpeed:(int)currentSpeed;
-(BOOL)isHeadOnTheBody;
-(BOOL)isHeadOnSomething:(NSMutableArray*)something;
-(void)changeHeadOfSnakeToDirection:(DirectionsEnum)direction isOnAim:(BOOL)isAim grid:(Grid*)grid;
-(BOOL)headPositionIsHaveAim;
-(void)nextAim:(Grid*)grid;
-(BOOL)isNextAimPositionOnSomething:(NSMutableArray*)something nextAimPosition:(CGPoint)position;
-(BOOL)isHeadOnGrid:(Grid*)grid;
-(int)numberOfHeadCell:(Grid*)grid;
-(void)redrawHeadToNoHeadStyle;
-(void)addPoints;
-(SquareTypesEnum)aimType;
-(void)setBarriers:(Grid*)grid fromFile:(NSString*)filePath;
-(NSMutableArray*)barriers;
@end
