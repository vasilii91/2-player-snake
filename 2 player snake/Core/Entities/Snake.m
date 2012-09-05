//
//  Snake.m
//  2 player snake
//
//  Created by Kasnitskij_V on 04.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Snake.h"

static int const SQUARE_SIZE = 10;

@implementation Snake

-(id)init
{   
    snake = [[NSMutableArray alloc] init];
    remainsOfTheSnake = [[NSMutableArray alloc] init];
    barriers = [[NSMutableArray alloc] init];
    self = [super init];
    
    return self;
}

+(id)alloc
{
	return [super alloc];
}

-(NSMutableArray*)snake
{
    return snake;
}

-(id)lastObject
{
    return [snake lastObject];
}

-(id)objectAtIndex:(NSUInteger)index 
{
    return [snake objectAtIndex:index];
}

-(id)dequeueFromEnd
{
    if ([snake count] == 0) {
        return nil;
    }
    
    id queueObject = [[[snake lastObject] retain] autorelease];
    [snake removeLastObject];
    
    return queueObject;
}

-(void)dequeue
{
    if ([snake count] != 0) {
        [[[snake objectAtIndex:0] retain] autorelease];
        [snake removeObjectAtIndex:0];
    }
}

-(void)enqueueToStart:(id)obj
{
    NSMutableArray *newSnake = [[NSMutableArray alloc] initWithCapacity:[snake count] + 1];
    [newSnake addObject:obj];
    for (Square *square in snake)
        [newSnake addObject:square];
    
    [snake removeAllObjects];
    [snake addObjectsFromArray:newSnake];
    [newSnake release];
}

-(void)enqueue:(id)obj
{
    [snake addObject: obj];
}

-(DirectionsEnum)currentDirection
{
    return currentDirection;
}

-(void)setCurrentDirection:(DirectionsEnum)direction
{
    currentDirection = direction;
}

-(SnakeSpeedEnum)snakeSpeed
{
    return snakeSpeed;
}

-(void)setSnakeSpeed:(SnakeSpeedEnum)speed
{
    snakeSpeed = speed;
}

-(CGPoint)headPosition
{
    return [[snake lastObject] position];
}

-(void)switchCurrentSpeed:(int)currentSpeed
{
    switch (currentSpeed) {
        case 1:
            snakeSpeed = SPEED_X1;
            break;
        case 2:
            snakeSpeed = SPEED_X2;
            break;
        case 3:
            snakeSpeed = SPEED_X3;
            break;
        case 4:
            snakeSpeed = SPEED_X4;
            break;
        case 5:
            snakeSpeed = SPEED_X5;
            break;
        case 6:
            snakeSpeed = SPEED_X6;
            break;
        case 7:
            snakeSpeed = SPEED_X7;
            break;
        case 8:
            snakeSpeed = SPEED_X8;
            break;
        case 9:
            snakeSpeed = SPEED_X9;
            break;
        case 10:
            snakeSpeed = SPEED_X10;
            break;
        case 11:
            snakeSpeed = SPEED_X11;
            break;
        case 12:
            snakeSpeed = SPEED_X12;
            break;
        case 13:
            snakeSpeed = SPEED_X13;
            break;
        case 14:
            snakeSpeed = SPEED_X14;
            break;
        case 15:
            snakeSpeed = SPEED_X15;
            break;
            
        default:
            break;
    }
}

-(BOOL)isHeadOnTheBody
{
    if ([self isHeadOnSomething:snake] ||
        [self isHeadOnSomething:remainsOfTheSnake] ||
        [self isHeadOnSomething:barriers])
    {
        return YES;
    }
    
    return NO;
}

-(BOOL)isHeadOnSomething:(NSMutableArray *)something
{
    Square *head = [snake lastObject];
    
    for (Square *square in something)
    {
        if (square != head)
        {
            if (head.position.x == square.position.x &&
                head.position.y == square.position.y)
                return YES;
        }
    }
    return NO;
}

-(void)changeHeadOfSnakeToDirection:(DirectionsEnum)direction isOnAim:(BOOL)isAim grid:(Grid *)grid
{
    int headCellNumber = [self numberOfHeadCell:grid];
    int newHeadCellNumber = 0;
    
    Square *newSquare = [Square square: HEAD];
    Square *head = [snake lastObject];
    
    CGPoint headPosition = [head position];
    
    if ([grid isReadyToExitAtOutOfBounds:direction numberOfHeadCell:headCellNumber] == NO)
    {
        switch (direction) {
            case UP:
                newSquare.position = ccp(headPosition.x, headPosition.y + SQUARE_SIZE);
                break;
            case RIGHT:
                newSquare.position = ccp(headPosition.x + SQUARE_SIZE, headPosition.y);
                break;
            case DOWN:
                newSquare.position = ccp(headPosition.x, headPosition.y - SQUARE_SIZE);
                break;
            case LEFT:
                newSquare.position = ccp(headPosition.x - SQUARE_SIZE, headPosition.y);
                break;
            default:
                break;
        }
    }
    else
    {
        switch (direction) {
            case UP:
                newHeadCellNumber = headCellNumber % [grid colNumber];
                break;
            case RIGHT:
                newHeadCellNumber = headCellNumber + 1  - [grid colNumber];
                break;
            case DOWN:
                newHeadCellNumber = [grid totalCountOfCells] - ([grid colNumber] - headCellNumber);
                break;
            case LEFT:
                newHeadCellNumber = headCellNumber + [grid colNumber] - 1;
                break;
            default:
                break;
        }
        
        newSquare.position = [grid cellCoordinateByNumber:newHeadCellNumber];
    }
    
    if (isAim) {
        switch (aim->currentSquareType) {
            case AIM:
                [self enqueue:newSquare];
                break;
                
            case SNAKE_EXTENTION:
                for (int i = 0; i < (int)SNAKE_EXTENTION; i++) {
                    [self enqueue:newSquare];
                }
            break;
                
            case SNAKE_NARROW:
            default:
                break;
        }
    }
    else {
        [self enqueue:newSquare];
    }

    if (isAim) {
        switch (aim->currentSquareType) {
            case SNAKE_NARROW:
                for (int i = 0; i < (int)SNAKE_NARROW; i++) {
                    [remainsOfTheSnake addObject: [self dequeueFromEnd]];
                }
                [self enqueue:newSquare];
                [self dequeue];
                break;
                
            case AIM:
            case SNAKE_EXTENTION:
            default:
                break;
        }
    }
    else {
        [self dequeue];
    }
    
//    if (isAim)
//    // Generate new aim
//    [self nextAim:grid];
}

-(BOOL)headPositionIsHaveAim
{
    Square *head = nil;
    head = [snake lastObject];
    if (aim.position.x == head.position.x &&
        aim.position.y == head.position.y) {
        return YES;
    }
    
    return NO;
}

-(void)addPoints
{
    points += (int)aim->currentSquareType;
}

-(SquareTypesEnum)aimType
{
    return aim->currentSquareType;
}

-(BOOL)isNextAimPositionOnSomething:(NSMutableArray *)something nextAimPosition:(CGPoint)position
{
    for (Square *square in something)
    {
        if (square.position.x == position.x &&
            square.position.y == position.y) 
        {
            return NO;
        }
    }
    
    return YES;
}

-(void)nextAim:(Grid *)grid
{
    BOOL isReadyToCreateNewAim = NO;
    CGPoint newAimPosition;
    while (!isReadyToCreateNewAim) 
    {
        int randomNumber = arc4random() % ([grid totalCountOfCells] - 1);
        newAimPosition = [grid cellCoordinateByNumber:randomNumber];
        if ([self isNextAimPositionOnSomething:snake nextAimPosition:newAimPosition] &&
            [self isNextAimPositionOnSomething:remainsOfTheSnake nextAimPosition:newAimPosition] &&
            [self isNextAimPositionOnSomething:barriers nextAimPosition:newAimPosition])
        {
            isReadyToCreateNewAim = YES;
        }
    }
    
    //    [aim release];
    int randomSquare = arc4random() % 5;
    Square *newAim = nil;
    
    switch (randomSquare) {
        case 0:
            newAim = [Square square:SNAKE_NARROW];
            break;
        case 1:
            newAim = [Square square:SNAKE_EXTENTION];
            break;
        case 2:
        case 3:
        case 4:
            newAim = [Square square:AIM];
            break;
        default:
            break;
    }
    
    newAim.position = newAimPosition;
    
    aim = newAim;
}

-(BOOL)isHeadOnGrid:(Grid *)grid
{
    Square *head = [snake lastObject];
    
    for (Cell *cell in [grid gridArray])
    {
        if ([cell coordinates].x == head.position.x &&
            [cell coordinates].y == head.position.y)
            return YES;
    }
    
    return NO;
}

-(int)numberOfHeadCell:(Grid *)grid
{
    Square *head = [snake lastObject];
    
    for (Cell *cell in [grid gridArray])
    {
        if ([cell coordinates].x == head.position.x &&
            [cell coordinates].y == head.position.y)
            return [cell cellNumber];
    }
    return -1;
}

-(void)redrawHeadToNoHeadStyle
{
    Square *curHead = [snake lastObject];
    CGPoint position = curHead.position;
    
    Square *head = [Square square:BODY_PART];
    head.position = position;
    
    [snake removeLastObject];
    [snake addObject:head];
}

-(NSMutableArray*)remainsOfTheSnake
{
    return remainsOfTheSnake;
}

-(void)deleteRemainsOfTheSnake
{
    for (id obj in remainsOfTheSnake) {
        [[[remainsOfTheSnake objectAtIndex:0] retain] autorelease];
        [remainsOfTheSnake removeObjectAtIndex:0];
    }
}

-(void)setBarriers:(Grid *)grid fromFile:(NSString *)filePath
{
    NSMutableArray *barrierCellNumbers = [grid getBarriersFromFile:filePath];
    
    for (NSString *barrierNumber in barrierCellNumbers)
    {
        CGPoint barrierCoordinate = [grid cellCoordinateByNumber:[barrierNumber intValue]];
        Square *barrier = [Square square:BARRIER];
        barrier.position = barrierCoordinate;
        [barriers addObject:barrier];
    }
}

-(NSMutableArray*)barriers
{
    return barriers;
}
@end
