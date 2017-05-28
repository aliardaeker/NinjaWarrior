//
//  GameView.m
//  Ninja Warrior
//
//  Created by ali arda eker on 5/5/17.
//  Copyright © 2017 AliArdaEker. All rights reserved.
//

#import "GameView.h"

@implementation GameView

#define ninjasPositionY height - height/5
#define widthBetweenBots 2
#define ninjaHeight 50
#define ninjaWidth 30

@synthesize player, width, height, bots, moveRight, playerXPos, moveLeft, playerHealth, playerDies, animation, jumpFlag, playerInitialY, jumpInnerFlag, blades, numOfBladesAdded, war;

// One time created elements after the view is loaded
- (void) createElements
{
    // Background music
    NSString *path = [NSString stringWithFormat:@"%@/war.wav", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    war = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
    [war setNumberOfLoops:-1];
    [war setVolume:1];
    [war play];
    
    width = [self bounds].size.width;
    height = [self bounds].size.height;
    
    jumpFlag = false;
    jumpInnerFlag = true;
    animation = true;
    
    // Main player
    player = [[NinjaPlayer alloc] initWithImage:@"ninja1" width:ninjaWidth height:ninjaHeight zPosition:1];
    [player setCenter:CGPointMake(width/2, ninjasPositionY)];
    [self addSubview:player];
    
    bots = [[NSMutableArray alloc] init];
    blades = [[NSMutableArray alloc] init];
    
    // Lables are initialized here
    playerHealth = [[UILabel alloc] initWithFrame:CGRectMake(25, 25, 120, 30)];
    NSString *str = [NSString stringWithFormat:@"%i", [player getHealth]];
    NSString *newStr = [@"Health: " stringByAppendingString:str];
    [playerHealth setText:newStr];
    playerHealth.textAlignment = NSTextAlignmentLeft;
    playerHealth.layer.zPosition = 11;
    [playerHealth setFont:[UIFont fontWithName:@"Arial-BoldMT" size:20]];
    playerHealth.textColor = [UIColor blackColor];
    [self addSubview:playerHealth];
    
    numOfBladesAdded = [[UILabel alloc] initWithFrame:CGRectMake(width - 145, 25, 120, 30)];
    str = [NSString stringWithFormat:@"%i", [player getNumOfBlades]];
    newStr = [@"Blades: " stringByAppendingString:str];
    [numOfBladesAdded setText:newStr];
    numOfBladesAdded.textAlignment = NSTextAlignmentRight;
    numOfBladesAdded.layer.zPosition = 11;
    [numOfBladesAdded setFont:[UIFont fontWithName:@"Arial-BoldMT" size:20]];
    numOfBladesAdded.textColor = [UIColor blackColor];
    [self addSubview:numOfBladesAdded];
    
    NinjaBot *bot = [[NinjaBot alloc] initWithImage:@"ninjaBot1" width:ninjaWidth height:ninjaHeight zPosition:1];
    [bot setCenter:CGPointMake(-1 * ninjaWidth, ninjasPositionY)];
    [bot setFace:true];
    [bot startAnimating];
    [bots addObject:bot];
    [self addSubview:bot];
    
    playerDies = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 50)];
    [playerDies setCenter:CGPointMake(width / 2, height / 2)];
    [playerDies setText:@"NINJA DEAD"];
    playerDies.textAlignment = NSTextAlignmentCenter;
    playerDies.layer.zPosition = 11;
    [playerDies setFont:[UIFont fontWithName:@"Arial-BoldMT" size:22]];
    playerDies.textColor = [UIColor redColor];
    [playerDies setHidden:YES];
    [self addSubview:playerDies];
}

// Refresing healt label after player takes a hit
- (void) refreshHealthLabel
{
    NSString *str = [NSString stringWithFormat:@"%i", [player getHealth]];
    NSString *newHealth = [@"Health: " stringByAppendingString:str];
    [playerHealth setText:newHealth];
}

// Label to show how many blades user has left with
- (void) refreshBladeLabel
{
    NSString *str = [NSString stringWithFormat:@"%i", [player getNumOfBlades]];
    NSString *newStr = [@"Blades: " stringByAppendingString:str];
    [numOfBladesAdded setText:newStr];
}

// Animation function
- (void) arrange: (CADisplayLink *) sender
{
    // When user dies animation stops
    if (animation)
    {
        [self animateNinjaPlayer];
        [self createNinjaBots];
        [self moveNinjaBots];
        [self detectCombat];
        if (jumpFlag) [self jump];
        [self throwBlade];
    }
}

// If bots are close enough to the user, they attack
- (void) detectCombat
{
    int playerX = [player center].x;
    int playerY = [player center].y;
    
    for(NinjaBot *bot in bots)
    {
        int botX = [bot center].x;
        int botY = [bot center].y;

        if (abs(botX - playerX) < 30 && abs(botY - playerY) < 15)
        {
            if ([bot getCombatStarted] == false)
            {
                // Bots change from walking animation to attack animation
                [bot stopAnimating];
                [bot animateCombat];
                [bot startAnimating];
            }
            
            [bot setCombatStarted:true];
            [player setHealt:-1];
            
            if ([player getHealth] < 0) [self playerDead];
            
            [self refreshHealthLabel];
        }
        else
        {
            if ([bot getCombatStarted] == true)
            {
                // Bots change to walking animation from attack animation
                [bot stopAnimating];
                [bot animateChasing];
                [bot startAnimating];
            }
            
            [bot setCombatStarted:false];
        }
    }
}

// When player dies labels are reset and animation stops
- (void) playerDead
{
    [playerDies setHidden:NO];
    [playerHealth setHidden:YES];
    [numOfBladesAdded setHidden:YES];
    animation = false;
    
    for(int i = 0; i < [bots count]; i++) [bots[i] botWins];
    [player ninjaDead];
    
    //[self setRestartTimer:[self TICKS_FOR_SECONDS:5]];
}

// Player moves right or left
- (void) animateNinjaPlayer
{
    if (moveRight)
    {
        int x = [player center].x;
        int y = [player center].y;
        [player setCenter:CGPointMake(x + 2, y)];
        
        if (x > playerXPos + 25) moveRight = false;
    }
    
    if (moveLeft)
    {
        float x = [player center].x;
        float y = [player center].y;
        [player setCenter:CGPointMake(x - 2, y)];
        
        if (x < playerXPos - 25) moveLeft = false;
    }
}

// Bots created here
- (void) createNinjaBots
{
    int r = rand() % 100;
    
    // They are create by 0.01 chance in every loop of the animation code
    // that is 30 frames in a second
    if (r == 0)
    {
        NinjaBot *bot;
        
        int r = rand() % 2;
        
        // They come from left or right side towards to the player
        if (r == 0)
        {
            bot = [[NinjaBot alloc] initWithImage:@"ninjaBot1" width:ninjaWidth height:ninjaHeight zPosition:1];
            [bot setCenter:CGPointMake(-1 * ninjaWidth, ninjasPositionY)];
            [bot setFace:true];
        }
        else
        {
            bot = [[NinjaBot alloc] initWithImage:@"ninjaBotL1" width:ninjaWidth height:ninjaHeight zPosition:1];
            [bot setCenter:CGPointMake(width + ninjaWidth, ninjasPositionY)];
            [bot setFace:false];
        }
    
        [bot startAnimating];
        [bots addObject:bot];
        [self addSubview:bot];
    }
}

// Bots approach to the main player until they get him.
- (void) moveNinjaBots
{
    for(NinjaBot *bot in bots)
    {
        if ([bot getCombatStarted] == false)
        {
            int x = [bot center].x;
            int y = [bot center].y;
        
            if ([bot getFace] == true) [bot setCenter:CGPointMake(x + widthBetweenBots, y)];
            else [bot setCenter:CGPointMake(x - widthBetweenBots, y)];
        }
    }
}

// Right button triggers this function
- (IBAction) ninjaMoveRight: (id) sender
{
    if (animation)
    {
        playerXPos = [player center].x;
    
        [player setFace:true];
        [player startAnimating];
        moveRight = true;
    }
}

// Left button triggers this function
- (IBAction) ninjaMoveLeft: (id) sender
{
    if (animation)
    {
        playerXPos = [player center].x;
    
        [player setFace:false];
        [player startAnimating];
        moveLeft = true;
    }
}

// Sword swinging button triggers this
- (IBAction) ninjaSword: (id) sender
{
    if (animation)
    {
        // Player switch from walking to combating animation
        [player stopAnimating];
        [player swingSword];
        [player startAnimating];
    
        int playerX = [player center].x;
        int playerY = [player center].y;
        
        // Bots which are close enough take hit
        for(int i = 0; i < [bots count]; i++)
        {
            int botX = [bots[i] center].x;
            int botY = [bots[i] center].y;
            
            if (abs(playerY - botY) < 20)
            {
                // Bots should be in front of the player
                if ([player getFace] && (botX - playerX) < 50 && (botX - playerX) > 0)
                {
                    [bots[i] setHealt:-2];
                    
                    // Bots die with 2 sword hit
                    if ([bots[i] getHealth] < 0)
                    {
                        [bots[i] removeFromSuperview];
                        [bots removeObjectAtIndex:i];
                    }
                }
                else if ((![player getFace]) && (playerX - botX) < 50 && (playerX - botX) > 0)
                {
                    [bots[i] setHealt:-2];
                    if ([bots[i] getHealth] < 0)
                    {
                        [bots[i] removeFromSuperview];
                        [bots removeObjectAtIndex:i];
                    }
                }
            }
        }
    }
}

// Blade button triggers this
- (IBAction) ninjaBlade: (id) sender
{
    // If player has some blades he throws them one by one
    if ([player getNumOfBlades] > 0 && animation)
    {
        Blade *b = [[Blade alloc] init];
        
        int x = [player center].x;
        int y = [player center].y;
        
        [b setCenter:CGPointMake(x, y)];
        [b setFace:[player getFace]];
        
        [blades addObject:b];
        [self addSubview:b];
        
        [player bladeUsed];
        [self refreshBladeLabel];
    }
}

// Blades are thrown here
- (void) throwBlade
{
    // This loop is for traveling the blades
    for (int i = 0; i < [blades count]; i++)
    {
        int x = [blades[i] center].x;
        int y = [blades[i] center].y;
        
        if ([blades[i] getFace]) [blades[i] setCenter:CGPointMake(x + [blades[i] getSpeed], y)];
        else [blades[i] setCenter:CGPointMake(x - [blades[i] getSpeed], y)];
    }
    
    // If blades hit a bot, they die
    for (int i = 0; i < [blades count]; i++)
    {
        int x = [blades[i] center].x;
        int y = [blades[i] center].y;
        
        for(int j = 0; j < [bots count]; j++)
        {
            int botX = [bots[j] center].x;
            int botY = [bots[j] center].y;
            
            if (abs(x - botX) < 5 && abs(y - botY) < 15)
            {
                [bots[j] setHealt:[blades[i] getEffect]];
                
                if ([bots[j] getHealth] < 0)
                {
                    [bots[j] removeFromSuperview];
                    [bots removeObjectAtIndex:j];
                }
                
                [blades[i] removeFromSuperview];
                [blades removeObjectAtIndex:i];
            }
        }
    }
}

// Jump button triggers this
- (IBAction) ninjaJump: (id) sender
{
    if (!jumpFlag)
    {
        playerInitialY = [player center].y;
        jumpFlag = true;
    }
}

// Jump function to move player up and down
- (void) jump
{
    int playerX = [player center].x;
    int playerY = [player center].y;
    
    if (playerInitialY < (playerY + 60) && jumpInnerFlag) [player setCenter:CGPointMake(playerX, playerY - 6)];
    else
    {
        [player setCenter:CGPointMake(playerX, playerY + 4)];
        jumpInnerFlag = false;
    }
    
    if ([player center].y == playerInitialY)
    {
        jumpFlag = false;
        jumpInnerFlag = true;
    }
}

@end
