//
//  Cell.h
//  2 player snake
//
//  Created by Kasnitskij_V on 07.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Cell : NSObject {
    CGPoint coordinates;
    int cellNumber;
}

+(Cell*)cellWithCoordinate:(CGPoint)cellCoordinates;
+(Cell*)cellWithCoordinate:(CGPoint)cellCoordinates andNumber:(int)number;
-(void)setCoordinatesToCell:(CGPoint)cellCoordinates;
-(CGPoint)coordinates;
-(void)setNumberForCell:(int)number;
-(int)cellNumber;

@end
