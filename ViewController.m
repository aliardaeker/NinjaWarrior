//
//  ViewController.m
//  Ninja Warrior
//
//  Created by ali arda eker on 5/5/17.
//  Copyright © 2017 AliArdaEker. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize gameView, displayLink;

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Animation link is set here
    displayLink = [CADisplayLink displayLinkWithTarget:gameView selector:@selector(arrange:)];
    [displayLink setPreferredFramesPerSecond:30];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void) viewDidAppear:(BOOL)animated
{
    // Insert the background image
    UIImageView *iView;
    UIImage *image = [UIImage imageNamed:@"Desert"];
    CGRect bounds = [gameView bounds];
    
    // Background image is set to the device`s dimensions
    UIGraphicsBeginImageContext(bounds.size);
    [image drawInRect:CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    iView = [[UIImageView alloc] initWithImage:destImage];
    [self.view addSubview:iView];
    iView.layer.zPosition = -1;
    
    // Game begins
    [gameView createElements];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
