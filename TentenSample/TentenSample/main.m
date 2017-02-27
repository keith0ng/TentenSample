//
//  main.m
//  TentenSample
//
//  Created by Keith Samson on 26/02/2017.
//  Copyright © 2017 Keith Samson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Computer.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSUInteger print_tenten_begin = 50;
        NSUInteger main_begin = 0;
        
        Computer *computer = [[Computer alloc] initWithCapacity:100];
        [computer setAddress:print_tenten_begin];
        [computer insertInstruction:MULT withArgument:nil];
        [computer insertInstruction:PRINT withArgument:nil];
        [computer insertInstruction:RET withArgument:nil];
        [computer setAddress:main_begin];
        [computer insertInstruction:PUSH withArgument:[NSNumber numberWithUnsignedInteger:1009]];
        [computer insertInstruction:PRINT withArgument:nil];
        [computer insertInstruction:PUSH withArgument:[NSNumber numberWithUnsignedInteger:6]];
        [computer insertInstruction:PUSH withArgument:[NSNumber numberWithUnsignedInteger:101]];
        [computer insertInstruction:PUSH withArgument:[NSNumber numberWithUnsignedInteger:10]];
        [computer insertInstruction:CALL withArgument:[NSNumber numberWithUnsignedInteger:print_tenten_begin]];
        [computer insertInstruction:STOP withArgument:nil];
        [computer setAddress:main_begin];
        [computer execute];

    }
    return 0;
}
