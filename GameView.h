//
//  GameView.h
//  Ninja Warrior
//
//  Created by ali arda eker on 5/5/17.
//  Copyright © 2017 AliArdaEker. All rights reserved.
//

#ifndef GameView_h
#define GameView_h

#import <UIKit/UIKit.h>
#import "NinjaPlayer.h"
#import "NinjaBot.h"
#import "Blade.h"
#import <AVFoundation/AVFoundation.h>

@interface GameView : UIView

// Ninja player object to simulate main player of the user
@property (nonatomic, strong) NinjaPlayer * player;

// Animation code takes place here
- (void) arrange: (CADisplayLink *) sender;

// Create one time elements
- (void) createElements;

// Instances reletad to the dimension of the game view
@property (nonatomic) float width;
@property (nonatomic) float height;
@property (nonatomic) float playerXPos;
@property (nonatomic) int playerInitialY;

// Boolean instances to control animation
@property (nonatomic) bool moveRight;
@property (nonatomic) bool moveLeft;
@property (nonatomic) bool animation;
@property (nonatomic) bool jumpFlag;
@property (nonatomic) bool jumpInnerFlag;

// Labels to show player`s healt, number of blades and game over message
@property (nonatomic, strong) UILabel * playerHealth;
@property (nonatomic, strong) UILabel * numOfBladesAdded;
@property (nonatomic, strong) UILabel * playerDies;

// Data structures to hold enemy ninjas and blades of the player
@property (nonatomic, strong) NSMutableArray * bots;
@property (nonatomic, strong) NSMutableArray * blades;

// Background music
@property (nonatomic, strong) AVAudioPlayer * war;

@end

#endif /* GameView_h */
