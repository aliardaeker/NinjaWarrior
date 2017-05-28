//
//  Ninjas.m
//  Ninja Warrior
//
//  Created by ali arda eker on 5/5/17.
//  Copyright © 2017 AliArdaEker. All rights reserved.
//

#import "Ninjas.h"

@implementation Ninjas

- (id) initWithImage: (NSString *)imageName width:(CGFloat)width height:(CGFloat)height zPosition:(int)zPos
{
    self = [self initWithFrame:CGRectMake(0, 0, width, height)];
    
    UIImage *image = [UIImage imageNamed:imageName];
    [self setImage:image];
    
    self.layer.zPosition = zPos;
    
    return self;
}

@end
