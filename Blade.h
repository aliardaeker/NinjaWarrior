//
//  Blade.h
//  Ninja Warrior
//
//  Created by ali arda eker on 5/9/17.
//  Copyright © 2017 AliArdaEker. All rights reserved.
//

#ifndef Blade_h
#define Blade_h

#import <UIKit/UIKit.h>

@interface Blade : UIImageView

// Constructer
- (id) init;

// Setter and getter methods for blade class attributes
- (bool) getFace;
- (void) setFace: (bool)face;
- (int) getSpeed;
- (int) getEffect;

@end


#endif /* Blade_h */
