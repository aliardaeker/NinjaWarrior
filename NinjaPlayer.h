//
//  NinjaPlayer.h
//  Ninja Warrior
//
//  Created by ali arda eker on 5/5/17.
//  Copyright © 2017 AliArdaEker. All rights reserved.
//

#ifndef NinjaPlayer_h
#define NinjaPlayer_h

#import "Ninjas.h"

@interface NinjaPlayer : Ninjas

- (id) initWithImage: (NSString *)imageName width:(CGFloat)width height:(CGFloat)height zPosition:(int)zPos;

// Getter and setter methods of the ninja player class
- (bool) getFace;
- (void) setFace: (bool)rightOrLeft;
- (int) getHealth;
- (void) setHealt: (int)h;
- (void) swingSword;
- (void) resetHealt;
- (void) ninjaDead;
- (int) getNumOfBlades;
- (void) bladeUsed;

@end

#endif /* NinjaPlayer_h */
