//
//  HKVideoPlayerException.m
//  iOS Video Player
//
//  Created by Hai Kieu on 11/23/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import "HKVideoPlayerException.h"

@implementation HKVideoPlayerException

+(void)notImplementedYetExceptionAtFunction:(const char *)function
{
    [self notImplementedYetExceptionAtFunction:function withMessage:nil];
}

+(void)notImplementedYetExceptionAtFunction:(const char *)function withMessage:(NSString *)message
{
    NSException *ex = [NSException exceptionWithName:@"NotImplementedYetExcepttion" reason:[NSString stringWithFormat:@"Please implement method %s",function] userInfo:@{@"message":message?message:@"",@"stacktrace":[NSThread callStackSymbols]}];


//    NSLog(@"%@",[NSString stringWithFormat:@"NotImplementedYetExcepttion >>> %@",[NSString stringWithFormat:@"Please implement method %s",function]]);
    NSLog(@"%@",ex);
    
}

@end
