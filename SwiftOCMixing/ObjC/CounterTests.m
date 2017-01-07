//
//  CounterTests.m
//  SwiftOCMixing
//
//  Created by zenghao on 2017/1/7.
//  Copyright © 2017年 zenghao0708. All rights reserved.
//

#import "CounterTests.h"
#import "SwiftOCMixing-swift.h"

@implementation CounterTests

+ (void)test{
    // Invoke Swift Class
    Counter * counter = [[Counter alloc] initWithNum:3];
    [counter increase];
    [counter decrease];
    NSLog(@"count: %@", counter);
}

@end
