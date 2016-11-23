//
//  DictionaryStack.m
//  Afterthought
//
//  Created by Esteban Valle on 11/21/16.
//  Copyright © 2016 TVD. All rights reserved.
//

#import "DictionaryStack.h"
#import "SystemDict.h"

#define SYSTEMDICT = 0
#define GLOBALDICT = 1
#define USERDICT   = 2

@implementation DictionaryStack {

    NSMutableArray *stack;

    NSDictionary *systemDict;

    NSInteger currentIndex;

}


static DictionaryStack *sharedInstance;


# pragma mark - Objective-C Methods


+ (DictionaryStack *)getInstance {
    if (!sharedInstance) sharedInstance = [[DictionaryStack alloc] init];

    return sharedInstance;
}



- (instancetype)init {

    if (sharedInstance) return sharedInstance;

    self = [super init];
    if (self) {
    }
    return self;
}

- (void) setup {
    stack = [[NSMutableArray alloc] initWithCapacity:5];

    // add the system dictionary
    systemDict = [SystemDict systemDictionary];
    [stack addObject:systemDict];

    // add the global dictionary
    [stack addObject:[NSMutableDictionary dictionaryWithCapacity:1024]];

    // add the user dictionary
    [stack addObject:[NSMutableDictionary dictionaryWithCapacity:1024]];

    currentIndex = 2;

}

# pragma mark - Dictionary Methods

- (void)setToken:(Token *)value forKey:(Token *)key {

    if (!stack) [self setup];
     
    NSMutableDictionary *topUserDict = [stack lastObject];

    [topUserDict setObject:value forKey:key];
}

- (void)addUserDictionaryToStack:(NSDictionary *)userDict {
    if (!stack) [self setup];

    [stack addObject:userDict];
    currentIndex++;
}

- (SystemExecutionBlock)blockForExecutable:(Token *)executable {

    if (!stack) [self setup];


    if (executable.tokenType != Executable) {
        [NSException raise:@"Illegal Operation on Non-Executable Token" format:@"Attempt to execute a non-executable: %@", executable];
    }

    // Visit each dictionary in descending order (top-down)
    for (NSInteger i = currentIndex; i >= 0; i--){
        NSDictionary *currentDictionary = [stack objectAtIndex:i];

        SystemExecutionBlock returnedBlock = [currentDictionary objectForKey:executable];

        if (returnedBlock) return returnedBlock; // if the dictionary has the key, return it
                                                 // otherwise try the next-lower dictionary
    }

    [NSException raise:@"Undefined Symbol" format:@"Attempted to execute undefined symbol: %@", executable];

    return NULL;
}

@end
