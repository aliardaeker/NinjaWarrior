//
//  Blade.m
//  Ninja Warrior
//
//  Created by ali arda eker on 5/9/17.
//  Copyright © 2017 AliArdaEker. All rights reserved.
//

#import "Blade.h"

@implementation Blade
{
    int speed;
    int effect;
    bool facingRight;
}

- (id) init
{
    self = [self initWithFrame:CGRectMake(0, 0, 14, 14)];
    
    UIImage *image = [UIImage imageNamed:@"blade"];
    [self setImage:image];
    
    self.layer.zPosition = 12;
    
    speed = 6;
    effect = -4;
    
    return self;
}

- (bool) getFace
{
    return facingRight;
}

- (void) setFace: (bool)face
{
    facingRight = face;
}

- (int) getSpeed
{
    return speed;
}

- (int) getEffect
{
    return effect;
}

@end

