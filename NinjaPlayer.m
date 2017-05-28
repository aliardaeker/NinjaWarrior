//
//  NinjaPlayer.m
//  Ninja Warrior
//
//  Created by ali arda eker on 5/5/17.
//  Copyright © 2017 AliArdaEker. All rights reserved.
//

#import "NinjaPlayer.h"

@implementation NinjaPlayer
{
    int health;
    int anger;
    int numberOfBlades;
    bool facingRight;
}

- (id) initWithImage: (NSString *)imageName width:(CGFloat)width height:(CGFloat)height zPosition:(int)zPos
{
    self = [super initWithImage:imageName width:width height:height zPosition:zPos];
    
    health = 100;
    anger = 0;
    numberOfBlades = 10;
    facingRight = true;
    
    return self;
}

- (bool) getFace
{
    return facingRight;
}

- (void) setFace: (bool)rightOrLeft
{
    facingRight = rightOrLeft;
 
    [self walkingPosition];
}

// Walking animation code is set here
- (void) walkingPosition
{
    if (facingRight)
    {
        UIImage *i = [UIImage imageNamed:@"ninja1"];
        UIImage *i2 = [UIImage imageNamed:@"ninja2"];
        UIImage *i3 = [UIImage imageNamed:@"ninja3"];
        UIImage *i4 = [UIImage imageNamed:@"ninja4"];
        
        self.animationImages = @[i2, i3, i4, i];
        self.animationDuration = 0.5;
        self.animationRepeatCount = 1;
        [self setImage:i];
    }
    else
    {
        UIImage *i = [UIImage imageNamed:@"ninjaL1"];
        UIImage *i2 = [UIImage imageNamed:@"ninjaL2"];
        UIImage *i3 = [UIImage imageNamed:@"ninjaL3"];
        UIImage *i4 = [UIImage imageNamed:@"ninjaL4"];
        
        self.animationImages = @[i2, i3, i4, i];
        self.animationDuration = 0.5;
        self.animationRepeatCount = 1;
        [self setImage:i];
    }

}

// Combating animation code is set here
- (void) swingSword
{
    if (facingRight)
    {
        UIImage *i = [UIImage imageNamed:@"attack1"];
        UIImage *i2 = [UIImage imageNamed:@"attack2"];
        UIImage *i3 = [UIImage imageNamed:@"attack3"];
        UIImage *i4 = [UIImage imageNamed:@"attack4"];
        
        self.animationImages = @[i, i2, i3, i4];
        self.animationDuration = 0.5;
        self.animationRepeatCount = 1;
    }
    else
    {
        UIImage *i = [UIImage imageNamed:@"attackL1"];
        UIImage *i2 = [UIImage imageNamed:@"attackL2"];
        UIImage *i3 = [UIImage imageNamed:@"attackL3"];
        UIImage *i4 = [UIImage imageNamed:@"attackL4"];
        
        self.animationImages = @[i, i2, i3, i4];
        self.animationDuration = 0.5;
        self.animationRepeatCount = 1;
    }

}

- (void) ninjaDead
{
    UIImage *i;
    
    if ([self getFace] == true) i = [UIImage imageNamed:@"playerDead"];
    else i = [UIImage imageNamed:@"playerDeadL"];
    
    [self setImage:i];
}

- (int) getHealth
{
    return health;
}

- (void) setHealt: (int)h
{
    health = health + h;
}

- (void) resetHealt
{
    health = 100;
}

- (int) getNumOfBlades
{
    return numberOfBlades;
}

- (void) bladeUsed
{
    numberOfBlades = numberOfBlades - 1;
}

@end
