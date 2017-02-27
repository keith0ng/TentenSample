//
//  Computer.m
//  TentenSample
//
//  Created by Keith Samson on 26/02/2017.
//  Copyright © 2017 Keith Samson. All rights reserved.
//

#import "Computer.h"

@interface Computer()

@property (nonatomic, strong) NSMutableArray *argumentStack;
@property (nonatomic, assign) NSUInteger argumentIndex;
@property (nonatomic, assign) NSUInteger returnIndex;

@end

@implementation Computer

- (id)initWithCapacity:(NSUInteger)capacity {
    if (self = [super init]) {
        self.argumentIndex = 0;
        self.argumentStack = [NSMutableArray array]; // I created a different stack for all the values to be processed. Different from the instruction stack.
        self.instructionStack = [NSMutableArray arrayWithCapacity:capacity];
        // iOS cannot create an array with predefined empty value even when capacity is defined.
        // Therefore, I populated an array with empty objects based on the defined capacity.
        for (int i = 0 ; i < capacity; i++) {
            [self.instructionStack addObject:[NSNull null]];
        }
    }
    return self;
}

- (void)setAddress:(NSUInteger)index {
    self.instructionIndex = index;
}

- (void)insertInstruction:(Instructions)instruction withArgument:(id)argument {
    // Assuming most of the argument is an integer.
    
    if (!argument) {
        argument = [NSNull null];
    }
    NSDictionary *dict = @{[NSNumber numberWithInt:instruction] : argument};
    [self.instructionStack replaceObjectAtIndex:self.instructionIndex withObject:dict];
    self.instructionIndex += 1;
}

- (void)execute {
    // Recursive execution. Not the most efficient way I think.
    if (self.instructionStack.count <= 0) {
        return;
    }
    
    NSDictionary *instructionDictionary = [self.instructionStack objectAtIndex:self.argumentIndex];
    self.argumentIndex += 1;
    if (instructionDictionary != nil) {
        NSInteger instruction = [[[instructionDictionary allKeys] firstObject] integerValue];
        id argument = [[instructionDictionary allValues] firstObject];
        [self evaluateInstruction:instruction withArgument:argument];
    }
    [self execute];
}

- (void)evaluateInstruction:(NSInteger)instruction withArgument:(id)argument {
    switch (instruction) {
        case MULT: {
            [self multiplyArgumentFromStack];
            break;
        }
        case CALL: {
            [self callAddress:argument];
            break;
        }
        
        case RET: {
            [self returnToAddress];
            break;
        }
        
        case STOP: {
            [self stopExecution];
            break;
        }
        
        case PRINT: {
            [self printArgumentFromStack];
            break;
        }
            
        case PUSH: {
            [self pushArgumentToStack:argument];
            break;
        }
            
        default:
            break;
    }
    
}

- (void)pushArgumentToStack:(id)argument {
    NSLog(@"PUSH %@", argument);
    [self.argumentStack addObject:argument];
}

- (void)printArgumentFromStack {
    NSLog(@"PRINT");
    NSUInteger lastObjectIndex = [self.argumentStack indexOfObject:[self.argumentStack lastObject]];
    NSLog(@"%@", [self.argumentStack objectAtIndex:lastObjectIndex]);
    [self.argumentStack removeObjectAtIndex:lastObjectIndex];
}

- (void)stopExecution {
    NSLog(@"STOP");
    self.instructionStack = nil;
    return;
}

- (void)returnToAddress {
    NSLog(@"RET %tu", self.returnIndex);
    self.argumentIndex = self.returnIndex;
}

- (void)callAddress:(id)argument {
    NSLog(@"CALL %@", argument);
    self.returnIndex = self.argumentIndex;
    self.argumentIndex = [argument unsignedIntegerValue];
}

- (void)multiplyArgumentFromStack {
    // TODO: Handler to check if object from stack is not integer
    NSUInteger lastObjectIndex = [self.argumentStack indexOfObject:[self.argumentStack lastObject]];
    NSUInteger multiplicand = [[self.argumentStack objectAtIndex:lastObjectIndex] integerValue];
    NSUInteger multiplier = [[self.argumentStack objectAtIndex:lastObjectIndex - 1] integerValue];
    
    NSLog(@"MULT %tu %tu",multiplicand, multiplier);

    NSUInteger product =  multiplicand * multiplier;
    [self.argumentStack removeObjectAtIndex:lastObjectIndex];
    [self.argumentStack removeObjectAtIndex:lastObjectIndex-1];
    [self.argumentStack addObject:[NSNumber numberWithUnsignedInteger:product]];
}

@end
