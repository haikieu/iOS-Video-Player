//
//  HKVideoPlayerDefaultTheme.m
//  iOS Video Player
//
//  Created by Hai Kieu on 11/22/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import "HKVideoPlayerDefaultTheme.h"
#import "HKVideoPlayerViewController.h"
#import "HKVideoPlayerCoreView.h"

@implementation HKVideoPlayerDefaultTheme

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

UIView *topBar;
-(void)renderThemeOnPlayerVC:(HKVideoPlayerViewController *)playerVC
{
    [super renderThemeOnPlayerVC:playerVC];
    topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
    topBar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    [self addSubview:topBar];
    
    UIView *bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 40, self.bounds.size.width, 40)];
    bottomBar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    [self addSubview:bottomBar];
}
-(BOOL)playerShouldDraggableAtPosition:(CGPoint)postion
{
    return CGRectContainsPoint(topBar.frame, postion);
}
-(void)playerDidPlay
{
  
}

-(void)setEventHandler
{
    
}

@end
