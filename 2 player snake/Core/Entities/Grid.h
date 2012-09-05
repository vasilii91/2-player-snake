//
//  Grid.h
//  2 player snake
//
//  Created by Kasnitskij_V on 07.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cell.h"
#import "cocos2d.h"
#import "Directions.h"

@interface Grid : NSObject {
    NSMutableArray *gridArray;
    int totalHeight;
    int totalWidth;
    int cellSize;
    CGPoint leftBottomPoint;
    CGPoint rightUpperPoint;
    int rowNumber;
    int colNumber;
    int totalCountOfCells;
}

+(Grid*)gridWithSquareSize:(int)size andLeftBottomPoint:(CGPoint)lbPoint andRightUpperPoint:(CGPoint)ruPoint;
-(CGPoint)cellCoordinateByNumber:(int)number;
-(void)splitGridOnCells;
-(NSMutableArray*)gridArray;
-(int)totalHeight;
-(void)setTotalHeight:(int)height;
-(int)totalWidth;
-(void)setTotalWidth:(int)width;
-(int)cellSize;
-(void)setCellSize:(int)size;
-(CGPoint)leftBottomPoint;
-(void)setLeftBottomPoint:(CGPoint)point;
-(CGPoint)rightUpperPoint;
-(void)setRightUpperPoint:(CGPoint)point;
-(int)colNumber;
-(int)rowNumber;
-(BOOL)isReadyToExitAtOutOfBounds:(DirectionsEnum)currentDirection numberOfHeadCell:(int)number;
-(int)totalCountOfCells;
-(NSMutableArray*)getBarriersFromFile:(NSString*)pathToFile;
@end
