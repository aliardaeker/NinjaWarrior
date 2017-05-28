//
//  NinjaBot.h
//  Ninja Warrior
//
//  Created by ali arda eker on 5/7/17.
//  Copyright © 2017 AliArdaEker. All rights reserved.
//

#ifndef NinjaBot_h
#define NinjaBot_h

#import "Ninjas.h"

@interface NinjaBot : Ninjas

- (id) initWithImage: (NSString *)imageName width:(CGFloat)width height:(CGFloat)height zPosition:(int)zPos;

// Getter and setter for ninja bot class
- (bool) getFace;
- (void) setFace: (bool)rightOrLeft;
- (bool) getCombatStarted;
- (void) setCombatStarted: (bool)combatStarts;
- (int) getHealth;
- (void) setHealt: (int)h;
- (void) animateCombat;
- (void) animateChasing;
- (void) botWins;

@end

#endif /* NinjaBot_h */
