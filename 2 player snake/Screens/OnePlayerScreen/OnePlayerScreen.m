//
//  OnePlayerScreen.m
//  2 player snake
//
//  Created by Kasnitskij_V on 03.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OnePlayerScreen.h"

@class Snake;

static int DELAY_TO_SHOW_PLUS_POINTS = 1800;

@implementation OnePlayerScreen

+ (id)scene 
{
    // 'scene' is an autorelease object
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object
    OnePlayerScreen *layer = [OnePlayerScreen node];
    
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}

- (id)init 
{
    if ((self = [super initWithColor: ccc4(0, 100, 0, 255)])) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
//        CCMenuItem *backButton = [CCMenuItemFont itemFromString:@"BACK" target:self selector:@selector(backFunction:)];
        CCMenuItem *backButton = [CCMenuItemImage itemFromNormalImage:@"button_cancel.png" selectedImage:@"button_cancel.png" target:self selector:@selector(backFunction:)];
        [backButton setScale:BUTTON_SCALE];
        backButton.position = ccp(-winSize.width / 2 + backButton.contentSize.width / 4 + 5, winSize.height / 2 - backButton.contentSize.height / 4);
        
        CCMenuItem *rightButton = [CCMenuItemImage itemFromNormalImage:@"Icon-Small-50.png" selectedImage:@"Icon-Small@2x.png" target:self selector:@selector(rightButtonTapped:)];
        
        rightButton.position = ccp(winSize.width / 2 - [rightButton contentSize].width / 2 * BUTTON_SCALE, 
                                    -winSize.height / 2 + ([rightButton contentSize].height / 2 + [rightButton contentSize].height) * BUTTON_SCALE);
        [rightButton setScale:BUTTON_SCALE];
        
        CCMenuItem *leftButton = [CCMenuItemImage itemFromNormalImage:@"Icon-Small-50.png" selectedImage:@"Icon-Small@2x.png" target:self selector:@selector(leftButtonTapped:)];
        
        leftButton.position = ccp(winSize.width / 2 - 2.5 * [leftButton contentSize].width * BUTTON_SCALE, 
                                   -winSize.height / 2 + 1.5 * [leftButton contentSize].height * BUTTON_SCALE);
        [leftButton setScale:BUTTON_SCALE];
        
        CCMenuItem *upButton = [CCMenuItemImage itemFromNormalImage:@"Icon-Small-50.png" selectedImage:@"Icon-Small@2x.png" target:self selector:@selector(upButtonTapped:)];
        
        upButton.position = ccp(winSize.width / 2 - 1.5 * [upButton contentSize].width * BUTTON_SCALE, 
                                   -winSize.height / 2 + 2.5 * [upButton contentSize].height * BUTTON_SCALE);
        [upButton setScale:BUTTON_SCALE];
        
        CCMenuItem *downButton = [CCMenuItemImage itemFromNormalImage:@"Icon-Small-50.png" selectedImage:@"Icon-Small@2x.png" target:self selector:@selector(downButtonTapped:)];
        
        downButton.position = ccp(winSize.width / 2 - 1.5 *[downButton contentSize].width * BUTTON_SCALE, 
                                   -winSize.height / 2 + [downButton contentSize].height / 2 * BUTTON_SCALE);
        [downButton setScale:BUTTON_SCALE];
        
        CCMenuItem *speedUp = [CCMenuItemImage itemFromNormalImage:@"Icon-Small-50.png" selectedImage:@"Icon-Small@2x.png" target:self selector:@selector(speedUpButtonTapped:)];
        
        speedUp.position = ccp(winSize.width / 2 - 1.5 * [upButton contentSize].width * BUTTON_SCALE, 
                               -winSize.height / 2 + 5.5 * [upButton contentSize].height * BUTTON_SCALE);
        [speedUp setScale:BUTTON_SCALE];
        
        CCMenuItem *speedDown = [CCMenuItemImage itemFromNormalImage:@"Icon-Small-50.png" selectedImage:@"Icon-Small@2x.png" target:self selector:@selector(speedDownButtonTapped:)];
        
        speedDown.position = ccp(winSize.width / 2 - 1.5 * [upButton contentSize].width * BUTTON_SCALE, 
                                 -winSize.height / 2 + 4.5 * [upButton contentSize].height * BUTTON_SCALE);
        [speedDown setScale:BUTTON_SCALE];
        
        CCMenu *mainMenu = [CCMenu menuWithItems:backButton, rightButton, leftButton, upButton, downButton, speedUp, speedDown, nil];        
        
        CGPoint leftBottomPoint = ccp(40, 40);
        CGPoint rightUpperPoint = ccp(440, 280);
        grid = [[Grid gridWithSquareSize:10 andLeftBottomPoint:leftBottomPoint andRightUpperPoint:rightUpperPoint] retain];
        
        CCMenuItemImage *backgroundImage = [CCMenuItemImage itemFromNormalImage:@"big_kletochki.jpg" selectedImage:@"big_kletochki.jpg"];
        backgroundImage.position = ccp(240, 160);
//        backgroundImage.contentSize = CGSizeMake(0, 0);
        [self addChild:backgroundImage];
        
        int numberOfCenterPoint = [grid rowNumber] * [grid colNumber] / 2 + [grid colNumber] / 2;
        
        Square *sq1 = [[Square square: BODY_PART] retain];
        sq1.position = [grid cellCoordinateByNumber:numberOfCenterPoint];
        Square *sq2 = [[Square square: BODY_PART] retain];
        sq2.position = [grid cellCoordinateByNumber:numberOfCenterPoint + 1];
        Square *sq3 = [[Square square: BODY_PART] retain];
        sq3.position = [grid cellCoordinateByNumber:numberOfCenterPoint + 2];
        Square *sq4 = [[Square square: BODY_PART] retain];
        sq4.position = [grid cellCoordinateByNumber:numberOfCenterPoint + 3];
        Square *sq5 = [[Square square: BODY_PART] retain];
        sq5.position = [grid cellCoordinateByNumber:numberOfCenterPoint + 4];
        Square *sq6 = [[Square square: HEAD] retain];
        sq6.position = [grid cellCoordinateByNumber:numberOfCenterPoint + 5];
        
        Square *sq7 = [Square square:AIM];
        sq7.position = [grid cellCoordinateByNumber:709];
        [self addChild:sq7];
        
        snake = [[Snake alloc] init];
        
        [self drawSquareOnScreen:sq1];
        [self drawSquareOnScreen:sq2];
        [self drawSquareOnScreen:sq3];
        [self drawSquareOnScreen:sq4];
        [self drawSquareOnScreen:sq5];
        [self drawSquareOnScreen:sq6];
        [sq1 release];
        [sq2 release];
        [sq3 release];
        [sq4 release];
        [sq5 release];
        [sq6 release];
        
//        [snake setAim:sq7];
        snake->aim = sq7;
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"map2" ofType:@"txt"];  
        [snake setBarriers:grid fromFile:filePath];
        
        for (Square *barrier in [snake barriers])
        {
            [self addChild:barrier];
        }

        // points of player
        points = [CCMenuItemFont itemFromString:@"0"];
        points.position = ccp(450, 300);
        
        // plus-points of player
        plusSomePoints = [CCMenuItemFont itemFromString:@" "];
        plusSomePoints.position = ccp(370, 270);
        [plusSomePoints setScale:1.5f];
        [plusSomePoints setColor:ccRED];
        
        // game over
        gameOver = [CCMenuItemFont itemFromString:@"GAME OVER"];
        gameOver.position = ccp(240, 160);
        [gameOver setScale:3.0f];
        [gameOver setColor:ccRED];
        [gameOver setVisible:NO];
        
        transparentBackground = [CCMenuItemImage itemFromNormalImage:@"TransparentBackground.png" selectedImage:@"TransparentBackground.png"];
        transparentBackground.position = ccp(240, 160);
        [transparentBackground setVisible:NO];
        
        [self addChild:mainMenu];
        [self addChild:plusSomePoints];
        [self addChild:transparentBackground];
        [self addChild:gameOver];
        [self addChild:points];
        
        [self schedule:@selector(nextFrame:)];
        [self schedule:@selector(plusSomePoints:)];
        [snake setSnakeSpeed:SPEED_X10];
        currentSpeed = 10;
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

- (void) plusSomePoints: (ccTime)dt
{
    if ([snake headPositionIsHaveAim]) 
    {
        keepPointsOnScreen = YES;
    }
    
    if (keepPointsOnScreen)
    {
        if (!showOnce)
        {
            [plusSomePoints.label setString: [NSString stringWithFormat:@"+%d", (int)[snake aimType]]];
            showOnce = YES;
        }
        if (delay > DELAY_TO_SHOW_PLUS_POINTS) 
        {
            [plusSomePoints.label setString:@" "];
            delay = 0;
            keepPointsOnScreen = NO;
            showOnce = NO;
            [aimSprite setVisible:NO];
        }
        else
        {
            delay += dt * 1000;
        }
    }
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
                [snake addPoints];
                [points.label setString:[NSString stringWithFormat:@"%d", snake->points]];
                
                
                [self changeDirection:YES];
                
                // Delete aim from grid
                [self removeChild:snake->aim cleanup:YES];
                
                // Generate new aim
                [snake nextAim:grid];
                // and add new aim to grid
                [self addChild:snake->aim];
                
                [aimSprite stopAllActions];
                [self showAimWithHelpAnimation:snake->aim.position];
            }
            else 
            {
                [self changeDirection:NO];
            }
            interval = 0;
        }
        else 
        {
            [gameOver setVisible:YES];
            [transparentBackground setVisible:YES];
        }
    }
}

-(void)changeDirection:(BOOL)isOnAim
{
    // redraw head to no-head style
    Square *square = [[snake snake] lastObject];
    [self removeChild:square cleanup:YES];
    [snake redrawHeadToNoHeadStyle];
    square = [[snake snake] lastObject];
    [self addChild:square];
    
    [self removeChild:[[snake snake] objectAtIndex:0] cleanup:YES];

    [snake changeHeadOfSnakeToDirection:[snake currentDirection] isOnAim:isOnAim grid:grid];
    
    [self addChild:[[snake snake] lastObject]];
    
//    if (isOnAim == YES && snake->aim->currentSquareType == SNAKE_NARROW) {
//        for (int i = 0; i < [[snake remainsOfTheSnake] count]; i++) {
//            [self removeChild:[[snake remainsOfTheSnake] objectAtIndex:0] cleanup:YES];
//        }
//        [snake deleteRemainsOfTheSnake];
//    }
}

- (void) registerWithTouchDispatcher {
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {

    // it show up when it is end of game
    if ([snake isHeadOnTheBody])
    {
        countOfClickWhenGameOver++;
        if (countOfClickWhenGameOver == 1) {
            [points.label setString:[NSString stringWithFormat:@"%d points", snake->points]];
            [points setColor:ccGREEN];
            [points runAction:[CCMoveTo actionWithDuration:1.0f position:ccp(250, 250)]];
            [points runAction:[CCScaleTo actionWithDuration:1.2f scale:2.0f]];
        }
        else if (countOfClickWhenGameOver == 2) {
            [self goToMainScreen];
        }
    }
    
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    CGPoint headLocation = [snake headPosition];
    DirectionsEnum currentDirection = [snake currentDirection];
    
    switch (currentDirection) {
        case LEFT:
        case RIGHT:
            if (touchLocation.y > headLocation.y) {
                [snake setCurrentDirection:UP];
            }
            else {
                [snake setCurrentDirection:DOWN];
            }
            break;
        case UP:
        case DOWN:
            if (touchLocation.x > headLocation.x) {
                [snake setCurrentDirection:RIGHT];
            }
            else {
                [snake setCurrentDirection:LEFT];
            }
            break;
    }
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
    [self goToMainScreen];
}

-(void)goToMainScreen
{
    [[CCDirector sharedDirector] replaceScene: [CCTransitionSlideInL transitionWithDuration:1 scene: [MainLayer scene]]];
}

-(void)showAimWithHelpAnimation:(CGPoint)position
{
    int FRAME_SIZE = 30;
    // create the sprite sheet
    CCSpriteBatchNode *aimSheet = [CCSpriteBatchNode batchNodeWithFile: @"PayAttentionHalf30.png"];
    [self addChild:aimSheet];
    
    // create the sprite
    aimSprite = [CCSprite spriteWithTexture:aimSheet.texture rect:CGRectMake(0, 0, FRAME_SIZE, FRAME_SIZE)];
    [aimSheet addChild:aimSprite];
    [aimSprite setVisible:YES];
    
    aimSprite.position = position;
    
    // create the animation
    CCAnimation *aimAnimation = [CCAnimation animationWithName:@"dance" delay:1.0f];
    
    for (int y = 0; y < 6; y++) {
        // create an animation frame
        CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:aimSheet.texture 
                                                          rect:CGRectMake(y*FRAME_SIZE,0,FRAME_SIZE,FRAME_SIZE)];
        [aimAnimation addFrame:frame];
    }
    
    // create the action
    CCAnimate *aimAction = [CCAnimate actionWithAnimation:aimAnimation];
    CCRepeatForever *repeat = [CCRepeatForever actionWithAction:aimAction];

    [aimSprite stopAllActions];
    // run the action
    [aimSprite runAction:repeat];
    
//    CGPoint headPosition = [snake headPosition];
//    if (previousPosition.x == headPosition.x &&
//        previousPosition.y == headPosition.y) {
//        [aimSprite stopAction:repeat];
//        [aimSprite setVisible:NO];
//        [repeat release];
//    }
    
//    [danceSprite setVisible:NO];
}

@end
