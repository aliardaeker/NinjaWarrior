//
//  NinjaBot.m
//  Ninja Warrior
//
//  Created by ali arda eker on 5/7/17.
//  Copyright © 2017 AliArdaEker. All rights reserved.
//

#import "NinjaBot.h"

@implementation NinjaBot
{
    int health;
    bool facingRight;
    bool combatStarted;
}

- (id) initWithImage: (NSString *)imageName width:(CGFloat)width height:(CGFloat)height zPosition:(int)zPos
{
    self = [super initWithImage:imageName width:width height:height zPosition:zPos];
    
    health = 3;
    facingRight = true;
    combatStarted = false;
    
    return self;
}

- (bool) getFace
{
    return facingRight;
}

- (void) setFace: (bool)rightOrLeft
{
    facingRight = rightOrLeft;
    
    [self animateChasing];
}

- (bool) getCombatStarted
{
    return combatStarted;
}

- (void) setCombatStarted: (bool)combatStarts
{
    combatStarted = combatStarts;
}

// Combating animation code
- (void) animateCombat
{
    if (facingRight)
    {
        UIImage *i = [UIImage imageNamed:@"botAttack1"];
        UIImage *i2 = [UIImage imageNamed:@"botAttack2"];
        UIImage *i3 = [UIImage imageNamed:@"botAttack3"];
        
        self.animationImages = @[i, i2, i3];
        self.animationDuration = 0.3;
    }
    else
    {
        UIImage *i = [UIImage imageNamed:@"botAttackL1"];
        UIImage *i2 = [UIImage imageNamed:@"botAttackL2"];
        UIImage *i3 = [UIImage imageNamed:@"botAttackL3"];
        
        self.animationImages = @[i, i2, i3];
        self.animationDuration = 0.3;
    }
}

// Walking animation code
- (void) animateChasing
{
    if (facingRight)
    {
        UIImage *i = [UIImage imageNamed:@"ninjaBot1"];
        UIImage *i2 = [UIImage imageNamed:@"ninjaBot2"];
        UIImage *i3 = [UIImage imageNamed:@"ninjaBot3"];
        UIImage *i4 = [UIImage imageNamed:@"ninjaBot4"];
        
        self.animationImages = @[i2, i3, i4, i];
        self.animationDuration = 0.5;
        
    }
    else
    {
        UIImage *i = [UIImage imageNamed:@"ninjaBotL1"];
        UIImage *i2 = [UIImage imageNamed:@"ninjaBotL2"];
        UIImage *i3 = [UIImage imageNamed:@"ninjaBotL3"];
        UIImage *i4 = [UIImage imageNamed:@"ninjaBotL4"];
        
        self.animationImages = @[i2, i3, i4, i];
        self.animationDuration = 0.5;
    }
}

- (void) botWins
{
    [self stopAnimating];
    UIImage *i = [UIImage imageNamed:@"winner"];
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

@end
