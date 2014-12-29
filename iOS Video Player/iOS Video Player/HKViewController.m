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
#import "HKUtility.h"
#import "HKVideoPlayerCoreView.h"
#import "HKVideoPlayerViewControllerDelegate.h"


@interface HKViewController ()<HKVideoPlayerViewControllerDelegate, UITableViewDelegate,UITableViewDataSource>

@property HKVideoPlayerViewController *playerVC;

@property (nonatomic,strong) UITableView * tableView;

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
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];
    
    [self.view addSubview:_tableView];
    

}

#pragma mark - UITableView datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

#pragma mark - UITableView delegate


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseIdentifier = @"reuse_menu_item";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    
    NSString * className = nil;
    NSString * title = nil;
    switch (indexPath.row) {
        case 0:
            className = @"HKVideoPlayerDefaultTheme";
            title = @"Default theme";
            break;
            
        case 1:
            
            className = @"HKVideoPlayerClassicalTheme";
            title = @"Classical theme";
            break;
    }
    
    cell.detailTextLabel.text = className;
    cell.textLabel.text = title;
    
    return cell;
}

static UIView * backgroundTheme;

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
        Class themeClass = NSClassFromString(cell.detailTextLabel.text);
    
        _playerVC = [[[HKVideoPlayerViewController alloc] initWithFrame:CGRectMake(60, 60, 600, 400) theme:[themeClass theme]] goingToAddSubview];
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
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                
                backgroundTheme = [[UIView alloc] initWithFrame:self.view.bounds];
                backgroundTheme.backgroundColor = [UIColor blackColor];
                backgroundTheme.alpha = 1;
            });
            
            [self.view addSubview:backgroundTheme];
            [self.view addSubview:_playerVC.view];
            
            _playerVC.view.alpha = 0;
            backgroundTheme.alpha = 0;
            [UIView animateWithDuration:1 animations:^{
                
                _playerVC.view.alpha = 1;
                backgroundTheme.alpha = 0.5;
            } completion:^(BOOL finished) {
                
                [_playerVC syncMediaToControlCenter:YES];
            }];
        }
    
        [_playerVC loadUrl:[NSURL URLWithString:URL_ADVANCED_STREAMING] autoPlay:YES];
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
            backgroundTheme.alpha = 0;
            view.alpha = 0;
        } completion:^(BOOL finished) {
            
            [backgroundTheme removeFromSuperview];
            
            [videoPlayer.themeView removeFromSuperview];
            [videoPlayer.coreView removeFromSuperview];
            [view removeFromSuperview];
        }];
        
    }
}

#pragma mark - Enhance orientation

-(BOOL)shouldAutorotate
{
    return NO;
    
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return NO;
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


@end
