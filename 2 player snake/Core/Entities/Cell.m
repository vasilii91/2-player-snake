//
//  Cell.m
//  2 player snake
//
//  Created by Kasnitskij_V on 07.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Cell.h"


@implementation Cell

+(Cell*)cellWithCoordinate:(CGPoint)cellCoordinates
{
    Cell *cell = [[Cell alloc] init];
    [cell setCoordinatesToCell: cellCoordinates];
    
    return [cell autorelease];
}

+(Cell*)cellWithCoordinate:(CGPoint)cellCoordinates andNumber:(int)number
{
    Cell *cell = [[Cell alloc] init];
    [cell setCoordinatesToCell: cellCoordinates];
    [cell setNumberForCell:number];
    
    return [cell autorelease];
}

-(void)setCoordinatesToCell:(CGPoint)cellCoordinates;
{
    coordinates = cellCoordinates;
}

-(CGPoint)coordinates
{
    return coordinates;
}

-(void)setNumberForCell:(int)number
{
    cellNumber = number;
}

-(int)cellNumber
{
    return cellNumber;
}

@end
