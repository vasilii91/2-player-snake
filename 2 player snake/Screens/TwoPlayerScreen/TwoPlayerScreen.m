//
//  TwoPlayerScreen.m
//  2 player snake
//
//  Created by Kasnitskij_V on 03.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwoPlayerScreen.h"


@implementation TwoPlayerScreen

+(id) scene 
{
    // 'scene' is an autorelease object
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object
    TwoPlayerScreen *layer = [TwoPlayerScreen node];
    
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}

-(id) init 
{
    if ((self = [super initWithColor: ccc4(0, 0, 50, 255)])) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        CCMenuItem *backButton = [CCMenuItemImage itemFromNormalImage:@"button_cancel.png" selectedImage:@"button_cancel.png" target:self selector:@selector(backFunction:)];
        [backButton setScale:BUTTON_SCALE];
        
        backButton.position = ccp(-winSize.width / 2 + backButton.contentSize.width / 4 + 5, winSize.height / 2 - backButton.contentSize.height / 4);
        
        CCMenuItem *rightButton = [CCMenuItemImage itemFromNormalImage:@"Icon-Small-50.png" selectedImage:@"Icon-Small@2x.png" target:self selector:@selector(rightButtonTapped:)];
        
        rightButton.position = ccp(winSize.width / 2 - [rightButton contentSize].width / 2, 
                                   -winSize.height / 2 + [rightButton contentSize].height / 2 + [rightButton contentSize].height);
        
        CCMenuItem *leftButton = [CCMenuItemImage itemFromNormalImage:@"Icon-Small-50.png" selectedImage:@"Icon-Small@2x.png" target:self selector:@selector(leftButtonTapped:)];
        
        leftButton.position = ccp(winSize.width / 2 - [leftButton contentSize].width / 2 - 2 * [leftButton contentSize].width, 
                                  -winSize.height / 2 + [leftButton contentSize].height / 2 + [leftButton contentSize].height);
        
        CCMenuItem *upButton = [CCMenuItemImage itemFromNormalImage:@"Icon-Small-50.png" selectedImage:@"Icon-Small@2x.png" target:self selector:@selector(upButtonTapped:)];
        
        upButton.position = ccp(winSize.width / 2 - [upButton contentSize].width / 2 - [upButton contentSize].width, 
                                -winSize.height / 2 + [upButton contentSize].height / 2 + 2 * [upButton contentSize].height);
        
        CCMenuItem *downButton = [CCMenuItemImage itemFromNormalImage:@"Icon-Small-50.png" selectedImage:@"Icon-Small@2x.png" target:self selector:@selector(downButtonTapped:)];
        
        downButton.position = ccp(winSize.width / 2 - [downButton contentSize].width / 2 - [downButton contentSize].width, 
                                  -winSize.height / 2 + [downButton contentSize].height / 2);
        
        
        CCMenuItem *speedUp = [CCMenuItemImage itemFromNormalImage:@"Icon-Small-50.png" selectedImage:@"Icon-Small@2x.png" target:self selector:@selector(speedUpButtonTapped:)];
        
        speedUp.position = ccp(-winSize.width / 2 + [speedUp contentSize].width / 2, 
                               -winSize.height / 2 + [speedUp contentSize].height / 2 + 2 * [speedUp contentSize].height);
        
        CCMenuItem *speedDown = [CCMenuItemImage itemFromNormalImage:@"Icon-Small-50.png" selectedImage:@"Icon-Small@2x.png" target:self selector:@selector(speedDownButtonTapped:)];
        
        speedDown.position = ccp(-winSize.width / 2 + [speedDown contentSize].width / 2, 
                                 -winSize.height / 2 + [speedDown contentSize].height / 2);
        
        CCMenu *mainMenu = [CCMenu menuWithItems:backButton, rightButton, leftButton, upButton, downButton, speedUp, speedDown, nil];        
        
        CGPoint leftBottomPoint = ccp(60, 0);
        CGPoint rightUpperPoint = ccp(420, 320);
        grid = [Grid gridWithSquareSize:10 andLeftBottomPoint:leftBottomPoint andRightUpperPoint:rightUpperPoint];
        
        CCMenuItemImage *backgroundImage = [CCMenuItemImage itemFromNormalImage:@"background.png" selectedImage:@"background.png"];
        backgroundImage.position = ccp(240,160);
        [self addChild:backgroundImage];
        
        int numberOfCenterPoint = [grid rowNumber] * [grid colNumber] / 2 + [grid colNumber] / 2;
        
        Square *sq1 = [Square square: BODY_PART];
        sq1.position = [grid cellCoordinateByNumber:numberOfCenterPoint];
        Square *sq2 = [Square square: BODY_PART];
        sq2.position = [grid cellCoordinateByNumber:numberOfCenterPoint + 1];
        Square *sq3 = [Square square: BODY_PART];
        sq3.position = [grid cellCoordinateByNumber:numberOfCenterPoint + 2];
        Square *sq4 = [Square square: BODY_PART];
        sq4.position = [grid cellCoordinateByNumber:numberOfCenterPoint + 3];
        Square *sq5 = [Square square: BODY_PART];
        sq5.position = [grid cellCoordinateByNumber:numberOfCenterPoint + 4];
        Square *sq6 = [Square square: HEAD];
        sq6.position = [grid cellCoordinateByNumber:numberOfCenterPoint + 5];
        
        Square *sq7 = [Square square:AIM];
        sq7.position = [grid cellCoordinateByNumber:109];
        [self addChild:sq7];
        
        snake = [[Snake alloc] init];
        
        [self drawSquareOnScreen:sq1];
        [self drawSquareOnScreen:sq2];
        [self drawSquareOnScreen:sq3];
        [self drawSquareOnScreen:sq4];
        [self drawSquareOnScreen:sq5];
        [self drawSquareOnScreen:sq6];
        
        snake->aim = sq7;
        
        [self addChild:mainMenu];
        
        [self schedule:@selector(nextFrame:)];
        [snake setSnakeSpeed:SPEED_X6];
        currentSpeed = 6;
        headIsLastObjectOfArray = YES;
        [snake setCurrentDirection:RIGHT];
        
        self.isTouchEnabled = YES;
    }
    
    return self;
}

-(void)drawSquareOnScreen:(Square*)square
{
    [snake enqueue:square];
    [self addChild:square];
}

- (void) nextFrame: (ccTime)dt {
    interval += dt * 1000;
    //110 - min, 1200 - max
    if (interval > (int)[snake snakeSpeed])
    {
        BOOL isAtAim = [snake headPositionIsHaveAim];
        BOOL isHeadToBody = [snake isHeadOnTheBody];
        
        if (isHeadToBody == NO)
        {
            if (isAtAim)
            {
                [self changeDirection:YES];
                
                // Delete aim from grid
                [self removeChild:snake->aim cleanup:YES];
                // Generate new aim
                [snake nextAim:grid];
                // and add new aim to grid
                [self addChild:snake->aim];
            }
            else 
            {
                [self changeDirection:NO];
            }
            interval = 0;
        }
    }
}

-(void)changeDirection:(BOOL)isOnAim
{
    Square *square = [[snake snake] lastObject];
    [self removeChild:square cleanup:YES];
    [snake redrawHeadToNoHeadStyle];
    square = [[snake snake] lastObject];
    [self addChild:square];
    
    [self removeChild:[[snake snake] objectAtIndex:0] cleanup:YES];
    
    [snake changeHeadOfSnakeToDirection:[snake currentDirection] isOnAim:isOnAim grid:grid];
    
    [self addChild:[[snake snake] lastObject]];
}

- (void) registerWithTouchDispatcher {
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
}

- (void) speedUpButtonTapped: (id)sender {
    currentSpeed++;
    if (currentSpeed > 15)
        currentSpeed = 15;
    
    [snake switchCurrentSpeed:currentSpeed];
}

- (void) speedDownButtonTapped: (id)sender {
    currentSpeed--;
    if (currentSpeed < 1)
        currentSpeed = 1;
    
    [snake switchCurrentSpeed:currentSpeed];
}


- (void) rightButtonTapped: (id)sender {
    if ([snake currentDirection] != LEFT)
        [snake setCurrentDirection:RIGHT];
}

- (void) leftButtonTapped: (id)sender {
    if ([snake currentDirection] != RIGHT)
        [snake setCurrentDirection:LEFT];
}

- (void) upButtonTapped: (id)sender {
    if ([snake currentDirection] != DOWN)
        [snake setCurrentDirection:UP];
}

- (void) downButtonTapped: (id)sender {
    if ([snake currentDirection] != UP)
        [snake setCurrentDirection:DOWN];
}

- (void)backFunction:(id)sender 
{
    [[CCDirector sharedDirector] replaceScene: [CCTransitionSlideInL transitionWithDuration:1 scene: [MainLayer scene]]];
}

@end
