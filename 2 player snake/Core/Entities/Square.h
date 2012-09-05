//
//  Square.h
//  2 player snake
//
//  Created by Kasnitskij_V on 04.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SquareTypes.h"

@interface Square : CCSprite {
    CCSprite *square;
    @public
        SquareTypesEnum currentSquareType;
}

+(Square*)square:(SquareTypesEnum)squareType;
-(void)setCurrentSquareType:(SquareTypesEnum)type;
-(CGSize)size;
-(int)width;
-(int)height;


@end
