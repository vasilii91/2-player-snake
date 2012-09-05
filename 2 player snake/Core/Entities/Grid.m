//
//  Grid.m
//  2 player snake
//
//  Created by Kasnitskij_V on 07.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Grid.h"

static int const SQUARE_SIZE = 10;

@implementation Grid

+(Grid*)gridWithSquareSize:(int)size andLeftBottomPoint:(CGPoint)lbPoint andRightUpperPoint:(CGPoint)ruPoint;
{
    Grid *grid = [[Grid alloc] init];
    
    int width = ruPoint.y - lbPoint.y;
    int height = ruPoint.x - lbPoint.x;
    
    [grid setCellSize:size];
    [grid setTotalWidth:width];
    [grid setTotalHeight:height];
    [grid setLeftBottomPoint:lbPoint];
    [grid setRightUpperPoint:ruPoint];
    
    [grid splitGridOnCells];
    
    return [grid autorelease];
}

-(void)splitGridOnCells
{
    gridArray = [[NSMutableArray alloc] init];
    int CELL_WIDTH = [self cellSize];
    int OFFSET_X = [self leftBottomPoint].x;
    int OFFSET_Y = [self leftBottomPoint].y;
    rowNumber = [self totalWidth] / CELL_WIDTH;
    colNumber = [self totalHeight] / CELL_WIDTH;
    totalCountOfCells = rowNumber * colNumber;
    int row = 0, col = 0, coordX = 0, coordY = 0;
    for (int i = 0; i < totalCountOfCells; i++) {
        coordX = col * CELL_WIDTH + OFFSET_X + SQUARE_SIZE / 2;
        coordY = row * CELL_WIDTH + OFFSET_Y + SQUARE_SIZE / 2;
        CGPoint coordinate = ccp(coordX, coordY);
        Cell *cell = [[Cell cellWithCoordinate:coordinate andNumber:i] retain];
        col++;
        if (col == colNumber) {
            col = 0;
            row++;
        }
        [gridArray addObject:cell];
        [cell release];
    }
}

-(CGPoint)cellCoordinateByNumber:(int)number
{
    for (Cell *cell in gridArray)
    {
        if ([cell cellNumber] == number)
            return [cell coordinates];
    }
    return ccp(0, 0);
}

-(NSMutableArray*)gridArray
{
    return gridArray;    
}

-(int)totalHeight
{
    return totalHeight;
}

-(void)setTotalHeight:(int)height
{
    totalHeight = height;
}

-(int)totalWidth
{
    return totalWidth;
}

-(void)setTotalWidth:(int)width
{
    totalWidth = width;
}

-(int)cellSize
{
    return cellSize;
}

-(void)setCellSize:(int)size
{
    cellSize = size;
}

-(CGPoint)leftBottomPoint
{
    return leftBottomPoint;
}

-(void)setLeftBottomPoint:(CGPoint)point
{
    leftBottomPoint = point;
}

-(CGPoint)rightUpperPoint
{
    return rightUpperPoint;
}

-(void)setRightUpperPoint:(CGPoint)point
{
    rightUpperPoint = point;
}

-(int)rowNumber
{
    return rowNumber;
}
-(int)colNumber
{
    return colNumber;
}

-(BOOL)isReadyToExitAtOutOfBounds:(DirectionsEnum)currentDirection numberOfHeadCell:(int)number
{
    int HEIGHT_IN_CELLS = totalHeight / SQUARE_SIZE;
    
    switch (currentDirection) {
        case UP:
            if (number + HEIGHT_IN_CELLS >= totalCountOfCells)
                return YES;
            break;
        case DOWN:
            if (number - HEIGHT_IN_CELLS < 0)
                return YES;
            break;
        case LEFT:
            if (((number - 1) % HEIGHT_IN_CELLS + 1) == HEIGHT_IN_CELLS || number == 0)
                return YES;
            break;
        case RIGHT:
            if ((number + 1) % HEIGHT_IN_CELLS == 0)
                return YES;
            break;
        default:
            break;
    }
    return NO;
}

-(int)totalCountOfCells
{
    return totalCountOfCells;
}

-(NSMutableArray*)getBarriersFromFile:(NSString *)pathToFile
{
    NSError *err = nil;
    NSString *contents = [NSString stringWithContentsOfFile:pathToFile encoding:NSUTF8StringEncoding error:&err];
    NSArray *barriers = [contents componentsSeparatedByString:@"\n"];
    
    return [NSMutableArray arrayWithArray:barriers];
}
                

@end
