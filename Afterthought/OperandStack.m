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
        currentIndex = 0;
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

    return stack[currentIndex];
}

- (NSInteger)size {
    return currentIndex;
}

- (Token *)pop {
    if (currentIndex == 0) {
        [NSException raise:@"Stack Underflow" format:@"Execution attempted to pop from an empty stack"];
    }

    Token *top = stack[currentIndex];
    [stack removeLastObject];
    currentIndex--;

    return top;
}

- (void)pushToken:(Token *)token {

    [stack addObject:token];
    currentIndex++;

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

    [retString appendString:@"##### TOP #####\n\n"];

    for (int i = (int)currentIndex - 1; i >= 0; i--) {
        [retString appendString:[NSString stringWithFormat:@"\t%@\n", [stack objectAtIndex:i]]];
    }

    [retString appendString:@"\n##### BOTTOM #####\n"];

    return retString;
}




@end
