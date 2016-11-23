//
//  OperandStack.m
//  Afterthought
//
//  Created by Esteban Valle on 11/20/16.
//  Copyright © 2016 TVD. All rights reserved.
//

#import "OperandStack.h"

@implementation OperandStack {

    NSMutableArray *stack;
    NSInteger currentIndex;

}

static OperandStack *instance;

# pragma mark - Singleton Methods

- (instancetype)init {

    if (instance) { // attempting to call 'init' on singleton
        @throw [NSException exceptionWithName:@"Already Instantiated" reason:@"Access OperandStack singleton with the -getInstance method" userInfo:nil];
    }


    self = [super init];
    if (self) {
        stack = [NSMutableArray arrayWithCapacity:1024]; // initial capacity for performance reasons
        currentIndex = -1;
    }
    return self;
}

/**
 *  Returns the singleton shared instance of the class
 *
 *  @return the OperandStack instance
 */
+ (OperandStack *)getInstance {

    if (!instance) {
        instance = [[OperandStack alloc] init];
    }

    return instance;
}


# pragma mark - Stack Methods

- (Token *) peek {
    return [stack lastObject];
}

- (NSInteger)size {
    return currentIndex + 1;
}

- (Token *)pop {
    if (currentIndex < 0) {
        [NSException raise:@"Stack Underflow" format:@"Execution attempted to pop from an empty stack"];
    }

    Token *top = [stack lastObject];
    [stack removeLastObject];
    currentIndex--;

    return top;
}

- (void)pushToken:(Token *)token {

    [stack addObject:token];
    currentIndex++;

}

- (void) rollLast:(NSInteger)objectCount by:(NSInteger)spaceCount {

    if (objectCount > currentIndex + 1){
        [NSException raise:@"Stack Underflow" format:@"Attempted to rotate %ld stack objects but there were only %ld", (long)objectCount, currentIndex];
    }

    spaceCount %= objectCount; // handle pesky input where the rolls are greater than the count to roll

    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:objectCount]; // temporary array
    NSInteger baseIndex = currentIndex - objectCount + 1;

    for (NSInteger count = 0; count < objectCount; count++) {

        NSInteger nextIndex = baseIndex + (objectCount - spaceCount + count) % objectCount; // handle wrapping

        Token *item = [stack objectAtIndex:nextIndex];
        [tempArray addObject:item];

    }

    [stack replaceObjectsInRange:NSMakeRange(baseIndex, objectCount) withObjectsFromArray:tempArray];

}

- (void) clearStack {
    [stack removeAllObjects];
    currentIndex = -1;
}

- (bool)containsMark {

    return [stack containsObject:[Token mark]];
}


/** 
 *  Selects the 'index-th' object from the top of the stack, where
 *  the top token of the stack is at index 0
 */
- (Token *)tokenAtPosition:(NSInteger)index {
    if (index > currentIndex) {
        [NSException raise:@"Out Of Range Exception" format:@"Attempted to access index out of stack boundries."];
    }

    return stack[currentIndex - index];
}



# pragma mark - Objective-C Methods

- (NSString *)description {
    NSMutableString *retString = [[NSMutableString alloc] init];

    [retString appendString:@"\n##### TOP #####\n\n"];

    for (int i = (int)currentIndex ; i >= 0; i--) {
        [retString appendString:[NSString stringWithFormat:@"\t%@\n", [stack objectAtIndex:i]]];
    }

    [retString appendString:@"\n##### BOTTOM #####\n"];

    return retString;
}




@end
