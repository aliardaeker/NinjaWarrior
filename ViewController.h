//
//  ViewController.h
//  Ninja Warrior
//
//  Created by ali arda eker on 5/5/17.
//  Copyright © 2017 AliArdaEker. All rights reserved.
//

#import "GameView.h"

@interface ViewController : UIViewController

// Game View object to access methods of the game logic
@property (nonatomic, strong) IBOutlet GameView *gameView;

// Animation link
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

