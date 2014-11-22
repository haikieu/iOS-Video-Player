//
//  HKVideoPlayerException.m
//  iOS Video Player
//
//  Created by Hai Kieu on 11/23/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import "HKVideoPlayerException.h"

@implementation HKVideoPlayerException

+(void)notImplementedYetExceptionAtFunction:(char *)function
{
    [NSException exceptionWithName:@"NotImplementedYetExcepttion" reason:[NSString stringWithFormat:@"Please implement method %s",function] userInfo:nil];
}

@end
