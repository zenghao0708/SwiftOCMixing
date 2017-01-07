//
//  NSObject+NSObject_Testable.m
//  ObjCDemos
//
//  Created by zenghao on 2016/11/11.
//  Copyright © 2016年 zenghao0708. All rights reserved.
//
#import "NSObject+Testable.h"
#import "objc/runtime.h"
#import "objc/message.h"

@implementation NSObject (Testable)


+ (void) test {
    NSLog(@"Testing: Begin");
    NSString * className = NSStringFromClass([self class]);
    NSLog(@"class: %@", className);
    
    id obj = [[[self class] alloc] init];


    int i=0;
    unsigned int mc = 0;
    Method * mlist = class_copyMethodList(object_getClass(obj), &mc);
    NSLog(@"%d methods", mc);
    for(i=0;i<mc;i++) {
        SEL selector = method_getName(mlist[i]);
        NSLog(@"Method no #%d: %s", i, sel_getName(selector));
        [obj performSelector:selector];
    }
    
    NSLog(@"Testing: End \n");
}

@end
