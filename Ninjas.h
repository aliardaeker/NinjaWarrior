//
//  Ninjas.h
//  Ninja Warrior
//
//  Created by ali arda eker on 5/5/17.
//  Copyright © 2017 AliArdaEker. All rights reserved.
//

#ifndef Ninjas_h
#define Ninjas_h

#import <UIKit/UIKit.h>

// Generic Ninja class, Ninja Player and Ninja Bot classes inherits this.

@interface Ninjas : UIImageView

// Generic ninja constructer
- (id) initWithImage: (NSString *)imageName width:(CGFloat)width height:(CGFloat)height zPosition:(int)zPos;

@end

#endif /* Ninjas_h */
