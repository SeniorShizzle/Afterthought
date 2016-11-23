//
//  ExecutionStack.m
//  Afterthought
//
//  Created by Esteban Valle on 11/22/16.
//  Copyright © 2016 TVD. All rights reserved.
//

#import "ExecutionStack.h"
#import "DictionaryStack.h"
#import "OperandStack.h"

@implementation ExecutionStack {

    NSMutableArray *stack;
    NSInteger currentIndex;

    OperandStack *opStack;
    DictionaryStack *dictStack;

    bool paused;

}

static ExecutionStack *sharedInstance;

+ (ExecutionStack *) getInstance {

    if (!sharedInstance){
        sharedInstance = [[ExecutionStack alloc] init];
    }

    return sharedInstance;
}

- (instancetype) init {

    if (sharedInstance) return sharedInstance;

    self = [super init];
    if (self) {
        stack = [NSMutableArray arrayWithCapacity:30];
        currentIndex = -1;
    }

    return self;
}

- (NSInteger)size {
    return currentIndex + 1;
}

# pragma mark - Execution Methods

- (void) pushContext:(Tokenizer *)context {

    [stack addObject:context];
    currentIndex++;

}

- (void) popAndResumeExecution {

    if (currentIndex < 0) return; // we're done executing the program

    [stack removeLastObject];
    currentIndex--;
}

- (void) run {

    /// Initialize and grab the other main stacks
    dictStack = [DictionaryStack getInstance];
    opStack = [OperandStack getInstance];

    paused = false;

    Tokenizer *context = [stack lastObject];

    Token *token = [context nextToken];

    SystemExecutionBlock runBlock;

    while (token){

        switch (token.tokenType) {
            case Bool:
            case Integer:
            case Literal:
            case Real:
            case Block:
            case Array:
            case String:
            case Mark:
            case Dictionary:
                [opStack pushToken:token];
                break;

            case Executable:
                // look up the executable in the dictionary stack
                // and follow the commands in that stack
                // or if it's not a literal or keyword, pop the referenced value onto the stack


                @try {
                    runBlock = [dictStack blockForExecutable:token];

                    if (runBlock) {
                        runBlock();
                    }
                } @catch (NSException *exception) {
                    NSLog(@"\n\n\n\tException Thrown By \'%@\':\n\t\t%@\n\n\nCurrent stack state: \n%@", token, exception, opStack);
                }

                break;

        }

        if (paused) break; // will have to be resumed manually by calling -run

        token = [context nextToken];
    }

    // Quit program execution if we've reached the end and haven't paused prematurely
    // Otherwise at this point we can drop down one level and resume the last thing we were doing
    if (!paused){
        if (currentIndex == 0) [self quit];
        else [self popAndResumeExecution];
    }
}


- (void) pause {

    paused = true;  // this will get caught by the runloop

}

- (void) quit {

    paused = true;

    [stack removeAllObjects];
    currentIndex = -1;

    NSLog(@"\n\n\nProgram Execution Complete. Current stack state:\n %@", opStack);

}


@end
