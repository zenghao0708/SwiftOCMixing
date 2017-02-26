//
//  NSStringDemos.m
//  ObjCDemos
//
//  Created by zenghao on 2016/11/11.
//  Copyright © 2016年 zenghao0708. All rights reserved.
//

#include "NSStringDemos.h"

@interface NSSStringDemos()

-(void) copyable;
- (void) Immutable;
- (void) mutable;

@end

@implementation NSSStringDemos

- (void) copyable {
    // 使用NSString的时候， copy 和 retain的是同一个对象
//    NSString * str = @"123";
//    NSString * str =  [NSMutableString stringWithString:@"123"];
    
    // 下面的代码会导致crash， 因为str实际上指向的是一个NSString对象，而不是MutableString,不能使用appendString
    //        NSMutableString * str = @"123";
    
    NSMutableString * str = [NSMutableString stringWithString:@"123"];
    // 使用NSMutableString的时候， copy会分配新的内存，而 retain指向原来的对象
    
    NSString * constString = @"123";
    
    NSString * rStr = [str retain];
    NSString * cStr = [str copy];
    NSString * rStr1 = [str retain];
    NSLog(@"Reference Count: cStr: %ld, rStr: %ld, rStr1: %ld", [cStr retainCount], [rStr retainCount], [rStr1 retainCount]);
    
    [str appendString:@" 321"];
    
    NSLog(@"Address: str: %p, rStr: %p, cStr: %p", str, rStr, cStr);
    NSLog(@"Address: cStr: %p, constString: %p", cStr, constString);
    
    // cStr是有MutableString copy出来的NSString, 而 rStr仍然是str的引用
    NSLog(@"rStr is NSMutableString: %d", [rStr isKindOfClass:[NSMutableString class]]);
    NSLog(@"cStr is NSMutableString: %d", [cStr isKindOfClass:[NSMutableString class]]);
    
    NSString * cStr1 = [cStr retain];
    NSLog(@"Reference Count: cStr: %ld, cStr1: %ld", [cStr retainCount], [cStr1 retainCount]);
    [cStr1 release];
    [cStr1 release];
    [cStr1 release];
    
    [str release];
    NSLog(@"Reference Count: rStr: %ld, rStr1: %ld", [rStr retainCount], [rStr1 retainCount]);
    [str release];
    NSLog(@"Reference Count: rStr: %ld, rStr1: %ld", [rStr retainCount], [rStr1 retainCount]);
    
    // 再次调用release就会crash
    //    [str release];
}

- (void) Immutable {
    NSString * str = @"123";
    NSString * str1 = @"123";
    
    NSLog(@"Address: str: %p, str1: %p", str, str1);
    NSLog(@"Reference Count: str: %ld, str1: %ld", [str retainCount], [str1 retainCount]);
    
    // NSString 的 copy 方法是浅复制，只是指针复制
    NSString * cStr = [str copy];
    // NSString 的 mutableCopy 方法是深复制，会开辟新的内存，进行内容复制
    NSString * mutableStr = [str mutableCopy];
    NSString * mStr = [str retain];
    
    // 设置 str 为 nil
    str = nil;
    
    NSLog(@"Address: cStr: %p, mStr: %p, mutableStr: %p", cStr, mStr, mutableStr);
    [cStr retain];
    
    // 常量 NSString 调用 dealloc 会导致 crash
//    [cStr dealloc];
    NSLog(@"Reference Count: cStr: %ld, mStr: %ld", [cStr retainCount], [mStr retainCount]);
    
    NSString * str3 = [[NSString alloc] initWithString:@"123"];
    NSLog(@"Address: str3: %p", str3);
    NSLog(@"Reference Count: str3: %ld", [str3 retainCount]);
    
    NSString * str4 = @"123";
    [str4 retain];
    
    NSLog(@"Address: str4: %p", str4);
    NSLog(@"Reference Count: str4: %ld", [str4 retainCount]);
    
    for(int i = 0; i < 10; i++) {
        [str release];
    }
    
    NSLog(@"Reference Count after release str for 10 times: str: %ld", [str retainCount]);
}

- (void) mutable {
    NSMutableString *mStr = [NSMutableString stringWithString:@"123"];
    NSMutableString *mStr1 = [NSMutableString stringWithString:@"123"];
    
    NSLog(@"Address: mStr: %p, mStr1: %p", mStr, mStr1);
    NSLog(@"Reference Count: mStr: %ld, mStr1: %ld", [mStr retainCount], [mStr1 retainCount]);
    
    [mStr1 retain];
    NSLog(@"Reference Count after retain: mStr: %ld, mStr1: %ld", [mStr retainCount], [mStr1 retainCount]);
    
    NSString * str2 = [mStr1 copy];
    NSLog(@"str2 Address: %p, retainCount: %ld", str2, [str2 retainCount]);
    
    [mStr release];
    NSLog(@"Address after release mStr: mStr: %p, mStr1: %p", mStr, mStr1);
    
    // 在release之后，对象已经被销毁了，调用appendString可能导致crash
//    [mStr appendString:@" 321"];
    
//     再次release会导致crash
//    [mStr release];
}

- (void) memoryLeak {
    for(long long i = 0; i < 200 * 1000 * 1000; i++) {
        NSString * str = [NSMutableString stringWithFormat:@"String - %lld", i];
        NSLog(@"str: %@", str);
    }
}

@end
