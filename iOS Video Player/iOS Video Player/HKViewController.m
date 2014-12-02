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
#import "HKVideoPlayerClassicalTheme.h"
@interface HKViewController ()

@property HKVideoPlayerViewController *playerVC;

@end

@implementation HKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _playerVC = [[HKVideoPlayerViewController alloc] initWithFrame:CGRectMake(20, 20, 600, 400) theme:[HKVideoPlayerDefaultTheme theme]];
    [_playerVC enableDragging];
    [_playerVC autoHideThemeView:YES afterTime:3];
    _playerVC.delegate = self;
    
    if(DEVICE_IS_IPHONE())
    {
        [self presentViewController:_playerVC animated:YES completion:^{
            [_playerVC syncMediaToControlCenter:YES];
        }];
        
    }
    else
    {
        [self.view addSubview:_playerVC.view];
        [_playerVC syncMediaToControlCenter:YES];
    }
    
    [_playerVC loadUrl:[NSURL URLWithString:URL_ADVANCED_STREAMING] autoPlay:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
    
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
