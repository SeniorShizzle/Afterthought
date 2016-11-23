//
//  SystemDict.m
//  Afterthought
//
//  Created by Esteban Valle on 11/21/16.
//  Copyright © 2016 TVD. All rights reserved.
//

#import "SystemDict.h"
#import "OperandStack.h"

@implementation SystemDict

+ (NSDictionary *)systemDictionary {
    NSMutableArray *blocks = [NSMutableArray arrayWithCapacity:30];
    NSMutableArray *keys    = [NSMutableArray arrayWithCapacity:30];

    __block OperandStack *opStack = [OperandStack getInstance];  // declaring as block-accessible makes it easier


# pragma mark - Arithmetic Operations

    /// ADD
    // a b add c
    [keys addObject:[Token tokenWithExecutable:@"add"]];
    [blocks addObject:^{
        Token *b = [opStack pop];
        Token *a = [opStack pop];

        if ([b tokenType] == Integer && [a tokenType] == Integer){
            NSInteger x = [(NSNumber *)a.value integerValue];
            NSInteger y = [(NSNumber *)b.value integerValue];

            [opStack pushToken:[Token tokenWithInteger:x + y]];

        } else {
            double x = [(NSNumber *)[a value] doubleValue];
            double y = [(NSNumber *)[b value] doubleValue];

            [opStack pushToken:[Token tokenWithReal:[NSNumber numberWithFloat:x + y]]];
        }

    }];

    /// SUB
    // a b sub c
    [keys addObject:[Token tokenWithExecutable:@"sub"]];
    [blocks addObject:^{
        Token *b = [opStack pop];
        Token *a = [opStack pop];

        if ([b tokenType] == Integer && [a tokenType] == Integer){
            NSInteger x = [(NSNumber *)a.value integerValue];
            NSInteger y = [(NSNumber *)b.value integerValue];

            [opStack pushToken:[Token tokenWithInteger:x - y]];

        } else {
            double x = [(NSNumber *)[a value] doubleValue];
            double y = [(NSNumber *)[b value] doubleValue];

            [opStack pushToken:[Token tokenWithReal:[NSNumber numberWithFloat:x - y]]];
        }
        
    }];


    /// MUL
    // a b mul c
    [keys addObject:[Token tokenWithExecutable:@"mul"]];
    [blocks addObject:^{
        Token *b = [opStack pop];
        Token *a = [opStack pop];

        if ([b tokenType] == Integer && [a tokenType] == Integer){
            NSInteger x = [(NSNumber *)a.value integerValue];
            NSInteger y = [(NSNumber *)b.value integerValue];

            [opStack pushToken:[Token tokenWithInteger:x * y]];

        } else {
            double x = [(NSNumber *)[a value] doubleValue];
            double y = [(NSNumber *)[b value] doubleValue];

            [opStack pushToken:[Token tokenWithReal:[NSNumber numberWithFloat:x * y]]];
        }
        
    }];


    /// DIV
    // a b div c
    [keys addObject:[Token tokenWithExecutable:@"div"]];
    [blocks addObject:^{
        Token *b = [opStack pop];
        Token *a = [opStack pop];

        if ([b tokenType] == Integer && [a tokenType] == Integer){
            NSInteger x = [(NSNumber *)a.value integerValue];
            NSInteger y = [(NSNumber *)b.value integerValue];

            [opStack pushToken:[Token tokenWithInteger:x / y]];

        } else {
            double x = [(NSNumber *)[a value] doubleValue];
            double y = [(NSNumber *)[b value] doubleValue];

            [opStack pushToken:[Token tokenWithReal:[NSNumber numberWithFloat:x / y]]];
        }
        
    }];

    /// IDIV
    // a b idiv (int)c
    [keys addObject:[Token tokenFromString:@"idiv"]];
    [blocks addObject:^{
        Token *b = [opStack pop];
        Token *a = [opStack pop];

        if ([b tokenType] == Integer && [a tokenType] == Integer){
            NSInteger x = [(NSNumber *)a.value integerValue];
            NSInteger y = [(NSNumber *)b.value integerValue];

            [opStack pushToken:[Token tokenWithInteger:x / y]];

        } else {
            NSInteger x = [(NSNumber *)[a value] integerValue];
            NSInteger y = [(NSNumber *)[b value] integerValue];

            [opStack pushToken:[Token tokenWithInteger:x / y]];
        }
        
    }];


    /// MOD
    // a b mod c
    [keys addObject:[Token tokenWithExecutable:@"mod"]];
    [blocks addObject:^{
        Token *b = [opStack pop];
        Token *a = [opStack pop];

        if ([b tokenType] == Integer && [a tokenType] == Integer){
            NSInteger x = [(NSNumber *)a.value integerValue];
            NSInteger y = [(NSNumber *)b.value integerValue];

            [opStack pushToken:[Token tokenWithInteger:(x % y)]];

        } else {
            double x = [(NSNumber *)[a value] doubleValue];
            double y = [(NSNumber *)[b value] doubleValue];

            [opStack pushToken:[Token tokenWithReal:[NSNumber numberWithFloat:fmod(x, y)]]];
        }
        
    }];


    /// IDIV
    // a b idiv (int)c
    [keys addObject:[Token tokenFromString:@"idiv"]];
    [blocks addObject:^{
        Token *b = [opStack pop];
        Token *a = [opStack pop];

        if ([b tokenType] == Integer && [a tokenType] == Integer){
            NSInteger x = [(NSNumber *)a.value integerValue];
            NSInteger y = [(NSNumber *)b.value integerValue];

            [opStack pushToken:[Token tokenWithInteger:x / y]];

        } else {
            NSInteger x = [(NSNumber *)[a value] integerValue];
            NSInteger y = [(NSNumber *)[b value] integerValue];

            [opStack pushToken:[Token tokenWithInteger:x / y]];
        }

    }];


    /// COS
    // a cos b
    [keys addObject:[Token tokenFromString:@"cos"]];
    [blocks addObject:^{
        Token *a = [opStack pop];

        if ([a tokenType] != Integer || [a tokenType] != Real){
            [NSException raise:@"Malformed Input" format:@"Attempted to call cos on non-number %@", a];
        }

        float x = [(NSNumber *)[a value] floatValue] * 0.0174533; // conversion from float to radian

        [opStack pushToken:[Token tokenWithReal:[NSNumber numberWithFloat:cos(x)]]];

    }];


    /// SIN
    // a sin b
    [keys addObject:[Token tokenFromString:@"sin"]];
    [blocks addObject:^{
        Token *a = [opStack pop];

        if ([a tokenType] != Integer || [a tokenType] != Real){
            [NSException raise:@"Malformed Input" format:@"Attempted to call sin on non-number %@", a];
        }

        float x = [(NSNumber *)[a value] floatValue] * 0.0174533; // conversion from float to radian

        [opStack pushToken:[Token tokenWithReal:[NSNumber numberWithFloat:sin(x)]]];
        
    }];


    /// SQRT
    // a sqrt b
    [keys addObject:[Token tokenFromString:@"sqrt"]];
    [blocks addObject:^{
        Token *a = [opStack pop];

        if ([a tokenType] != Integer || [a tokenType] != Real){
            [NSException raise:@"Malformed Input" format:@"Attempted to call sqrt on non-number %@", a];
        }

        float x = [(NSNumber *)[a value] floatValue]; // conversion from float to radian

        [opStack pushToken:[Token tokenWithReal:[NSNumber numberWithFloat:sqrt(x)]]];
        
    }];


    /// ABS
    // a abs |a|
    [keys addObject:[Token tokenFromString:@"abs"]];
    [blocks addObject:^{
        Token *a = [opStack pop];

        if ([a tokenType] != Integer || [a tokenType] != Real){
            [NSException raise:@"Malformed Input" format:@"Attempted to call abs on non-number %@", a];
        }

        if ([a tokenType] == Integer){
            NSInteger x = [(NSNumber *)a.value integerValue];

            [opStack pushToken:[Token tokenWithInteger:labs(x)]];

        } else {

            float x = [(NSNumber *)[a value] floatValue];

            [opStack pushToken:[Token tokenWithReal:[NSNumber numberWithFloat:fabsf(x)]]];
        }

    }];


    /// NEG
    // a neg -a
    [keys addObject:[Token tokenFromString:@"neg"]];
    [blocks addObject:^{
        Token *a = [opStack pop];

        if ([a tokenType] != Integer || [a tokenType] != Real){
            [NSException raise:@"Malformed Input" format:@"Attempted to call neg on non-number %@", a];
        }

        if ([a tokenType] == Integer){
            NSInteger x = [(NSNumber *)a.value integerValue];

            [opStack pushToken:[Token tokenWithInteger:x * -1]];

        } else {

            float x = [(NSNumber *)[a value] floatValue];

            [opStack pushToken:[Token tokenWithReal:[NSNumber numberWithFloat:x * -1.0]]];
        }
        
    }];

    /// CEILING
    // a ceiling b
    [keys addObject:[Token tokenFromString:@"ceiling"]];
    [blocks addObject:^{
        Token *a = [opStack pop];

        if ([a tokenType] != Integer || [a tokenType] != Real){
            [NSException raise:@"Malformed Input" format:@"Attempted to call ceiling on non-number %@", a];
        }

        if ([a tokenType] == Integer){

            // don't have to do anything for integers
            [opStack pushToken:a];

        } else {

            float x = [(NSNumber *)[a value] floatValue];

            [opStack pushToken:[Token tokenWithReal:[NSNumber numberWithFloat:ceilf(x)]]];
        }
        
    }];


    /// FLOOR
    // a floor b
    [keys addObject:[Token tokenFromString:@"floor"]];
    [blocks addObject:^{
        Token *a = [opStack pop];

        if ([a tokenType] != Integer || [a tokenType] != Real){
            [NSException raise:@"Malformed Input" format:@"Attempted to call floor on non-number %@", a];
        }

        if ([a tokenType] == Integer){

            // don't have to do anything for integers
            [opStack pushToken:a];

        } else {

            float x = [(NSNumber *)[a value] floatValue];

            [opStack pushToken:[Token tokenWithReal:[NSNumber numberWithFloat:floorf(x)]]];
        }
        
    }];


    /// TRUNCATE
    // a truncate b
    [keys addObject:[Token tokenFromString:@"truncate"]];
    [blocks addObject:^{
        Token *a = [opStack pop];

        if ([a tokenType] != Integer || [a tokenType] != Real){
            [NSException raise:@"Malformed Input" format:@"Attempted to call truncate on non-number %@", a];
        }

        if ([a tokenType] == Integer){

            // don't have to do anything for integers
            [opStack pushToken:a];

        } else {

            float x = [(NSNumber *)[a value] floatValue];

            [opStack pushToken:[Token tokenWithReal:[NSNumber numberWithFloat:truncf(x)]]];
        }
        
    }];



# pragma mark - Stack Operations

    /// PSTACK
    // - pstack -
    [keys addObject:[Token tokenWithExecutable:@"pstack"]];
    [blocks addObject:^{
        NSLog(@"%@", opStack);
    }];


    /// =
    // a = -
    [keys addObject:[Token tokenWithExecutable:@"="]];
    [blocks addObject:^{
        NSLog(@"%@", [opStack pop]);
    }];


    /// DUP
    // a dup a a
    [keys addObject:[Token tokenWithExecutable:@"dup"]];
    [blocks addObject:^{
        Token *a = [opStack peek];
        [opStack pushToken:[a copy]]; // do a deep copy for safety
    }];


    /// EXCH
    // a b exch b a
    [keys addObject:[Token tokenWithExecutable:@"exch"]];
    [blocks addObject:^{
        Token *a = [opStack pop];
        Token *b = [opStack pop];

        [opStack pushToken:b];
        [opStack pushToken:a];
    }];


    /// POP
    // a pop -
    [keys addObject:[Token tokenWithExecutable:@"pop"]];
    [blocks addObject:^{
        [opStack pop];
    }];


    /// CLEAR
    // - clear -
    [keys addObject:[Token tokenWithExecutable:@"clear"]];
    [blocks addObject:^{
        [opStack clearStack];
    }];


    /// COUNT
    // - count -
    [keys addObject:[Token tokenWithExecutable:@"count"]];
    [blocks addObject:^{
        [opStack size];
    }];


    /// INDEX
    // i index a
    [keys addObject:[Token tokenWithExecutable:@"index"]];
    [blocks addObject:^{
        Token *a = [opStack pop];
        if (a.tokenType != Integer) {
            [NSException raise:@"Malformed Input" format:@"command \"index\" expects type Integer but was given %@", a];
        }

        NSInteger index = [(NSNumber *)a.value integerValue];

        if (index < 0) {
            [NSException raise:@"Out of Stack Range" format:@"Attempted to access invalid stack index %ld", index];
        }

        Token *b = [opStack tokenAtPosition:index];

        [opStack pushToken:[b copy]]; // deep copy for safety
    }];


    /// COPY
    // n copy a...
    [keys addObject:[Token tokenWithExecutable:@"copy"]];
    [blocks addObject:^{

        Token *a = [opStack pop];

        if (a.tokenType != Integer) {
            [NSException raise:@"Malformed Input" format:@"command \"copy\" expects type Integer but was given %@", a];
        }


        NSInteger copyCount = [(NSNumber *)a.value integerValue];

        for (NSInteger i = copyCount - 1; i >= 0; i--) {
            Token *b = [opStack tokenAtPosition:copyCount - 1]; // because we push one value per iteration, always access index n-1
            [opStack pushToken:[b copy]];
        }

    }];


    /// ROLL
    // n i roll a...
    [keys addObject:[Token tokenWithExecutable:@"roll"]];
    [blocks addObject:^{

        Token *i = [opStack pop];
        Token *n = [opStack pop];

        if (n.tokenType != Integer && i.tokenType != Integer) {
            [NSException raise:@"Malformed Input" format:@"command \"roll\" expects two type Integers but was given %@, %@", n, i];
        }


        NSInteger rollCount = [(NSNumber *)n.value integerValue];
        NSInteger shiftCount = [(NSNumber *)i.value integerValue];

        [opStack rollLast:rollCount by:shiftCount]; // easy enough
        
    }];


    /// COUNTTOMARK
    // mark ... counttomark n
    [keys addObject:[Token tokenWithExecutable:@"counttomark"]];
    [blocks addObject:^{

        if (![opStack containsMark]) {
            [NSException raise:@"Unmatched Mark" format:@"Attempted to counttomark with no mark in stack"];
        }

        NSInteger i = 0;
        NSInteger count = [opStack size];

        while ([opStack tokenAtPosition:i].tokenType != Mark && i < count) {
            i++;
        }

        [opStack pushToken:[Token tokenWithInteger:labs(i)]]; // labs() = absolute value

    }];


    /// CLEARTOMARK
    // mark ... cleartomark
    [keys addObject:[Token tokenWithExecutable:@"cleartomark"]];
    [blocks addObject:^{

        if (![opStack containsMark]) {
            [NSException raise:@"Unmatched Mark" format:@"Attempted to cleartomark with no mark in stack"];
        }

        Token *item;

        NSInteger i = 0;
        NSInteger count = [opStack size];

        while (item.tokenType != Mark && i < count) {
            item = [opStack pop];
            i++;
        }

    }];




    // compile all of the blocks and keys into the
    return [[NSDictionary alloc] initWithObjects:blocks forKeys:keys];
}

@end
