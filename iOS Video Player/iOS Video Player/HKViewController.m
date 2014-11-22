//
//  HKViewController.m
//  iOS Video Player
//
//  Created by Hai Kieu on 11/22/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import "HKViewController.h"
#import "HKVideoPlayerViewController.h"
#import "HKVideoPlayerDefaultTheme.h"

@interface HKViewController ()

@property HKVideoPlayerViewController *playerVC;

@end

@implementation HKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _playerVC = [[HKVideoPlayerViewController alloc] initWithFrame:CGRectMake(20, 20, 600, 400) theme:[HKVideoPlayerDefaultTheme theme]];
    [self.view addSubview:_playerVC.view];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_playerVC loadUrl:[NSURL URLWithString:URL_BASIC_STREAMING] autoPlay:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)videoPlayer:(HKVideoPlayerViewController *)videoPlayer didCloseView:(UIView *)view
{
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        [videoPlayer dismissViewControllerAnimated:YES completion:^{
           //TODO
        }];
    }
    else
    {
        [UIView animateWithDuration:1 animations:^{
            view.alpha = 0;
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
        
    }
}

@end
