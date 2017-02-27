//
//  Computer.h
//  TentenSample
//
//  Created by Keith Samson on 26/02/2017.
//  Copyright © 2017 Keith Samson. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, Instructions) {
    MULT = 0,
    CALL = 1,
    RET = 2,
    STOP = 3,
    PRINT = 4,
    PUSH = 5
};

@interface Computer : NSObject

@property (nonatomic, strong) NSMutableArray *instructionStack;
@property (nonatomic) NSUInteger instructionIndex;

- (void)execute;
- (id)initWithCapacity:(NSUInteger)capacity;
- (void)setAddress:(NSUInteger)index;
- (void)insertInstruction:(Instructions)instruction withArgument:(id)argument;

@end
