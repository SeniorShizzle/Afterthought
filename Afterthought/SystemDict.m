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

        if ([a tokenType] != Integer && [a tokenType] != Real){
            [NSException raise:@"Malformed Input" format:@"Attempted to call cos on non-number %@", a];
        }

        float x = [(NSNumber *)[a value] floatValue] * 0.0174532925; // conversion from float to radian

        [opStack pushToken:[Token tokenWithReal:[NSNumber numberWithFloat:cos(x)]]];

    }];


    /// SIN
    // a sin b
    [keys addObject:[Token tokenFromString:@"sin"]];
    [blocks addObject:^{
        Token *a = [opStack pop];

        if ([a tokenType] != Integer && [a tokenType] != Real){
            [NSException raise:@"Malformed Input" format:@"Attempted to call sin on non-number %@", a];
        }

        float x = [(NSNumber *)[a value] floatValue] * 0.0174532925; // conversion from float to radian

        [opStack pushToken:[Token tokenWithReal:[NSNumber numberWithFloat:sin(x)]]];
        
    }];


    /// ATAN
    // a atan b
    [keys addObject:[Token tokenFromString:@"atan"]];
    [blocks addObject:^{
        Token *b = [opStack pop]; // numerator
        Token *a = [opStack pop]; // denominator

        if ([a tokenType] != Integer && [a tokenType] != Real && [b tokenType] != Integer && [b tokenType] != Real){
            [NSException raise:@"Malformed Input" format:@"Attempted to call atan on non-numbers %@, %@", a, b];
        }

        float num = [(NSNumber *)[a value] floatValue]; 
        float den = [(NSNumber *)[b value] floatValue];

        float answer = atan2f(num, den) * 57.2957795; // conversion from radians to degrees
        answer += 360.0;  // PostScript atan function returns positive values only from 0..360
        answer = fmod(answer, 360);

        [opStack pushToken:[Token tokenWithReal:[NSNumber numberWithFloat:answer]]]; // a four-quadrant arctan implementation
        
    }];


    /// EXP
    // base exponent exp b^exp
    [keys addObject:[Token tokenFromString:@"exp"]];
    [blocks addObject:^{
        Token *b = [opStack pop]; // numerator
        Token *a = [opStack pop]; // denominator

        if ([a tokenType] != Integer && [a tokenType] != Real && [b tokenType] != Integer && [b tokenType] != Real){
            [NSException raise:@"Malformed Input" format:@"Attempted to call exp on non-numbers %@, %@", a, b];
        }

        // exp always returns Real numbers
        float base = [(NSNumber *)[a value] floatValue];
        float exp  = [(NSNumber *)[b value] floatValue];

        [opStack pushToken:[Token tokenWithReal:[NSNumber numberWithFloat:powf(base, exp)]]];
        
    }];


    /// LN
    // a ln b
    [keys addObject:[Token tokenFromString:@"ln"]];
    [blocks addObject:^{
        Token *a = [opStack pop];

        if ([a tokenType] != Integer && [a tokenType] != Real){
            [NSException raise:@"Malformed Input" format:@"Attempted to call ln on non-number %@", a];
        }

        float x = [(NSNumber *)[a value] floatValue]; // conversion from float to radian

        [opStack pushToken:[Token tokenWithReal:[NSNumber numberWithFloat:logf(x)]]]; // log() is natural logarithm
    }];


    /// LOG
    // a log b
    [keys addObject:[Token tokenFromString:@"log"]];
    [blocks addObject:^{
        Token *a = [opStack pop];

        if ([a tokenType] != Integer && [a tokenType] != Real){
            [NSException raise:@"Malformed Input" format:@"Attempted to call log on non-number %@", a];
        }

        float x = [(NSNumber *)[a value] floatValue]; // conversion from float to radian

        [opStack pushToken:[Token tokenWithReal:[NSNumber numberWithFloat:log10f(x)]]]; // log10() is base-10 logarithm
    }];


    /// RAND
    // - rand b
    [keys addObject:[Token tokenFromString:@"rand"]];
    [blocks addObject:^{

        [opStack pushToken:[Token tokenWithReal:[NSNumber numberWithFloat:arc4random()]]];
    }];


    /// SRAND
    // a srand -
    [keys addObject:[Token tokenFromString:@"srand"]];
    [blocks addObject:^{

        [opStack pop]; // we're expected to take something off the stack

        //
        // The random-number generator arc4random() is self-seeding and cannot be manually seeded
        // therefore this method does nothing. A discussion of the merits and downfalls of self-seeding
        // randomness functions is beyond the scope of this project, but suffice to say that the only
        // major downside is that reproducability cannot be introduced into the randomness for testing
        // purposes. I acknowledge that people sometimes need predictable sequences of random numbers to
        // test their algorithms, but respectfully suggest that those people should grow the fuck up.
        //
        //                                                                  -Esteban Valle
    }];


    /// RRAND
    // - rrand b
    [keys addObject:[Token tokenFromString:@"rrand"]];
    [blocks addObject:^{

        // well now we're fucked
        // (see above)

        [opStack pushToken:[Token tokenWithReal:[NSNumber numberWithFloat:arc4random()]]]; // I won't tell if you don't

    }];


    /// SQRT
    // a sqrt b
    [keys addObject:[Token tokenFromString:@"sqrt"]];
    [blocks addObject:^{
        Token *a = [opStack pop];

        if ([a tokenType] != Integer && [a tokenType] != Real){
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

        if ([a tokenType] != Integer && [a tokenType] != Real){
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

        if ([a tokenType] != Integer && [a tokenType] != Real){
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

        if ([a tokenType] != Integer && [a tokenType] != Real){
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

        if ([a tokenType] != Integer && [a tokenType] != Real){
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

        if ([a tokenType] != Integer && [a tokenType] != Real){
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


# pragma mark - String Operations

    /// STRING
    // a string (...)
    [keys addObject:[Token tokenFromString:@"string"]];
    [blocks addObject:^{
        Token *a = [opStack pop];

        if (a.tokenType != Integer) {
            [NSException raise:@"Malformed Input" format:@"command \"string\" expects type Integer but was given %@", a];
        }

        NSInteger length = [(NSNumber *)a.value integerValue];

        NSString *string = [[NSString alloc] init];
        string = [string stringByPaddingToLength:length withString:@" " startingAtIndex:0];


        [opStack pushToken:[Token tokenWithString:string]]; // empty string of length x
    }];


    /// LENGTH
    // (...) length a
    [keys addObject:[Token tokenFromString:@"length"]];
    [blocks addObject:^{
        Token *a = [opStack pop];

        if (a.tokenType != String) {
            [NSException raise:@"Malformed Input" format:@"command \"length\" expects type String but was given %@", a];
        }

        NSString *string = (NSString *)a.value;

        [opStack pushToken:[Token tokenWithInteger:string.length]];
    }];


    /// GET
    // (...) a get a
    [keys addObject:[Token tokenFromString:@"get"]];
    [blocks addObject:^{
        Token *a = [opStack pop];
        Token *b = [opStack pop];

        if (b.tokenType != String || a.tokenType != Integer) {
            [NSException raise:@"Malformed Input" format:@"command \"get\" expects String, Integer but was given %@, %@", b, a];
        }


        NSInteger index = [(NSNumber *)a.value integerValue];
        NSString *string = (NSString *)b.value;

        int charInt = [string characterAtIndex:index];

        [opStack pushToken:[Token tokenWithInteger:charInt]];
    }];


    /// PUT
    // (...) index char put (...)
    [keys addObject:[Token tokenFromString:@"put"]];
    [blocks addObject:^{
        Token *c = [opStack pop];
        Token *b = [opStack pop];
        Token *a = [opStack pop];

        if (a.tokenType != String || b.tokenType != Integer || c.tokenType != Integer) {
            [NSException raise:@"Malformed Input" format:@"command \"put\" expects String, Integer, Integer but was given %@, %@, %@", a, b, c];
        }


        NSInteger index = [(NSNumber *)b.value integerValue];
        char charval = (int)[(NSNumber *)c.value integerValue];
        NSString *string = (NSString *)a.value;

        NSMutableString *stringMut = [string mutableCopy];

        [stringMut replaceCharactersInRange:NSMakeRange(index, 1) withString:[NSString stringWithFormat:@"%c", charval]];

        [opStack pushToken:[Token tokenWithString:stringMut]];
    }];


# pragma mark - Bit and Boolean Operators

    /// EQ
    // a b eq bool
    [keys addObject:[Token tokenFromString:@"eq"]];
    [blocks addObject:^{
        Token *b = [opStack pop];
        Token *a = [opStack pop];

        if ([a isEqual:b]) {
            [opStack pushToken:[Token tokenWithBool:YES]];
        } else {
            [opStack pushToken:[Token tokenWithBool:NO]];
        }

    }];


    /// NE
    // a b ne bool
    [keys addObject:[Token tokenFromString:@"ne"]];
    [blocks addObject:^{
        Token *b = [opStack pop];
        Token *a = [opStack pop];

        if (![a isEqual:b]) {
            [opStack pushToken:[Token tokenWithBool:YES]];
        } else {
            [opStack pushToken:[Token tokenWithBool:NO]];
        }

    }];


    /// GE
    // a b ge bool
    [keys addObject:[Token tokenFromString:@"ge"]];
    [blocks addObject:^{
        Token *b = [opStack pop];
        Token *a = [opStack pop];

        if (!(a.tokenType == String || a.tokenType != Integer) || !(b.tokenType == String || b.tokenType == Integer) || (a.tokenType != b.tokenType)){
            [NSException raise:@"Malformed Input" format:@"command \"ge\" expects 2 of same (String or Integer) but was given %@, %@", a, b];
        }

        Token *ret;

        switch ([a compareTo:b]) {
            case NSOrderedSame:
                ret = [Token tokenWithBool:YES]; // >=
                break;
            case NSOrderedDescending:
                ret = [Token tokenWithBool:NO];
                break;
            case NSOrderedAscending:
                ret = [Token tokenWithBool:YES];
                break;
        }

        [opStack pushToken:ret];

    }];


    /// GT
    // a b gt bool
    [keys addObject:[Token tokenFromString:@"gt"]];
    [blocks addObject:^{
        Token *b = [opStack pop];
        Token *a = [opStack pop];

        if (!(a.tokenType == String || a.tokenType != Integer) || !(b.tokenType == String || b.tokenType == Integer) || (a.tokenType != b.tokenType)){
            [NSException raise:@"Malformed Input" format:@"command \"gt\" expects 2 of same (String or Integer) but was given %@, %@", a, b];
        }

        Token *ret;

        switch ([a compareTo:b]) {
            case NSOrderedSame:
                ret = [Token tokenWithBool:NO]; // >
                break;
            case NSOrderedDescending:
                ret = [Token tokenWithBool:NO];
                break;
            case NSOrderedAscending:
                ret = [Token tokenWithBool:YES];
                break;
        }

        [opStack pushToken:ret];
        
    }];


    /// LE
    // a b le bool
    [keys addObject:[Token tokenFromString:@"le"]];
    [blocks addObject:^{
        Token *b = [opStack pop];
        Token *a = [opStack pop];

        if (!(a.tokenType == String || a.tokenType != Integer) || !(b.tokenType == String || b.tokenType == Integer) || (a.tokenType != b.tokenType)){
            [NSException raise:@"Malformed Input" format:@"command \"le\" expects 2 of same (String or Integer) but was given %@, %@", a, b];
        }

        Token *ret;

        switch ([a compareTo:b]) {
            case NSOrderedSame:
                ret = [Token tokenWithBool:YES]; // <=
                break;
            case NSOrderedDescending:
                ret = [Token tokenWithBool:YES];
                break;
            case NSOrderedAscending:
                ret = [Token tokenWithBool:NO];
                break;
        }

        [opStack pushToken:ret];
        
    }];


    /// LT
    // a b lt bool
    [keys addObject:[Token tokenFromString:@"lt"]];
    [blocks addObject:^{
        Token *b = [opStack pop];
        Token *a = [opStack pop];

        if (!(a.tokenType == String || a.tokenType != Integer) || !(b.tokenType == String || b.tokenType == Integer) || (a.tokenType != b.tokenType)){
            [NSException raise:@"Malformed Input" format:@"command \"le\" expects 2 of same (String or Integer) but was given %@, %@", a, b];
        }

        Token *ret;

        switch ([a compareTo:b]) {
            case NSOrderedSame:
                ret = [Token tokenWithBool:NO]; // <
                break;
            case NSOrderedDescending:
                ret = [Token tokenWithBool:YES];
                break;
            case NSOrderedAscending:
                ret = [Token tokenWithBool:NO];
                break;
        }

        [opStack pushToken:ret];
        
    }];


    /// AND
    // a b and bool|int
    [keys addObject:[Token tokenFromString:@"and"]];
    [blocks addObject:^{
        Token *b = [opStack pop];
        Token *a = [opStack pop];

        if (!(a.tokenType == Bool || a.tokenType != Integer) || !(b.tokenType == Bool || b.tokenType == Integer) || (a.tokenType != b.tokenType)){
            [NSException raise:@"Malformed Input" format:@"command \"le\" expects 2 of same (Boolean or Integer) but was given %@, %@", a, b];
        }

        if (a.tokenType == Bool){

            bool left  = [(NSNumber *)a.value boolValue];
            bool right = [(NSNumber *)b.value boolValue];

            bool result = left && right;

            [opStack pushToken:[Token tokenWithBool:result]];
        }

        if (a.tokenType == Integer){

            int left  = [(NSNumber *)a.value intValue];
            int right = [(NSNumber *)b.value intValue];

            int result = left & right;

            [opStack pushToken:[Token tokenWithInteger:result]];

        }

    }];


    /// OR
    // a b or bool|int
    [keys addObject:[Token tokenFromString:@"or"]];
    [blocks addObject:^{
        Token *b = [opStack pop];
        Token *a = [opStack pop];

        if (!(a.tokenType == Bool || a.tokenType != Integer) || !(b.tokenType == Bool || b.tokenType == Integer) || (a.tokenType != b.tokenType)){
            [NSException raise:@"Malformed Input" format:@"command \"or\" expects 2 of same (Boolean or Integer) but was given %@, %@", a, b];
        }

        if (a.tokenType == Bool){

            bool left  = [(NSNumber *)a.value boolValue];
            bool right = [(NSNumber *)b.value boolValue];

            bool result = left || right;

            [opStack pushToken:[Token tokenWithBool:result]];
        }

        if (a.tokenType == Integer){

            int left  = [(NSNumber *)a.value intValue];
            int right = [(NSNumber *)b.value intValue];

            int result = left | right;

            [opStack pushToken:[Token tokenWithInteger:result]];
            
        }
        
    }];


    /// XOR
    // a b xor bool|int
    [keys addObject:[Token tokenFromString:@"xor"]];
    [blocks addObject:^{
        Token *b = [opStack pop];
        Token *a = [opStack pop];

        if (!(a.tokenType == Bool || a.tokenType != Integer) || !(b.tokenType == Bool || b.tokenType == Integer) || (a.tokenType != b.tokenType)){
            [NSException raise:@"Malformed Input" format:@"command \"xor\" expects 2 of same (Boolean or Integer) but was given %@, %@", a, b];
        }

        if (a.tokenType == Bool){

            bool left  = [(NSNumber *)a.value boolValue];
            bool right = [(NSNumber *)b.value boolValue];

            bool result = left != right;

            [opStack pushToken:[Token tokenWithBool:result]];
        }

        if (a.tokenType == Integer){

            int left  = [(NSNumber *)a.value intValue];
            int right = [(NSNumber *)b.value intValue];

            int result = left ^ right;

            [opStack pushToken:[Token tokenWithInteger:result]];
            
        }
        
    }];


    /// NOT
    // a not bool|int
    [keys addObject:[Token tokenFromString:@"not"]];
    [blocks addObject:^{
        Token *a = [opStack pop];

        if (a.tokenType != Bool && a.tokenType != Integer){
            [NSException raise:@"Malformed Input" format:@"command \"not\" expects Boolean or Integer but was given %@", a];
        }

        if (a.tokenType == Bool){

            bool left  = [(NSNumber *)a.value boolValue];

            [opStack pushToken:[Token tokenWithBool:!left]];
        }

        if (a.tokenType == Integer){

            int result  = [(NSNumber *)a.value intValue];

            [opStack pushToken:[Token tokenWithInteger:~result]];
            
        }
        
    }];


    /// BITSHIFT
    // int shift bitshift int
    [keys addObject:[Token tokenFromString:@"bitshift"]];
    [blocks addObject:^{
        Token *b = [opStack pop];
        Token *a = [opStack pop];

        if (a.tokenType != Integer || b.tokenType != Integer){
            [NSException raise:@"Malformed Input" format:@"command \"bitshift\" expects Integer, Integer but was given %@, %@", a, b];
        }


        int number  = [(NSNumber *)a.value intValue];
        int shift = [(NSNumber *)b.value intValue];

        int result = shift > 0 ? number << shift : number >> shift; // if shift > 0 shift left

        [opStack pushToken:[Token tokenWithInteger:result]];

    }];


# pragma mark - Flow Control Operations

    /// EXEC
    // a exec -
    [keys addObject:[Token tokenFromString:@"exec"]];
    [blocks addObject:^{
        Token *b = [opStack pop];
        Token *a = [opStack pop];

        if ([a isEqual:b]) {
            [opStack pushToken:[Token tokenWithBool:YES]];
        } else {
            [opStack pushToken:[Token tokenWithBool:NO]];
        }

    }];


    /// EXIT
    // - exit -
    [keys addObject:[Token tokenFromString:@"exit"]];
    [blocks addObject:^{
        //TODO: Exit the innermost loop
    }];







    // compile all of the blocks and keys into the
    return [[NSDictionary alloc] initWithObjects:blocks forKeys:keys];
}

@end
