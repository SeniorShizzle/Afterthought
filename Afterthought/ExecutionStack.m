//
//  ExecutionStack.m
//  Afterthought
//
//  Created by Esteban Valle on 11/22/16.
//  Copyright © 2016 TVD. All rights reserved.
//

#import "ExecutionStack.h"

@implementation ExecutionStack {

    NSMutableArray *stack;

    NSInteger currentIndex;

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

- (void) pushContext:(Tokenizer *)context {

    [stack addObject:context];
    currentIndex++;


    [self executeProgram];

}

- (void) popAndResumeExecution {

    if (currentIndex < 0) return; // we're done executing the program

}

- (void) executeProgram {



}


@end
