//
//  DictionaryStack.m
//  Afterthought
//
//  Created by Esteban Valle on 11/21/16.
//  Copyright © 2016 TVD. All rights reserved.
//

#import "DictionaryStack.h"

#define SYSTEMDICT = 0
#define GLOBALDICT = 1
#define USERDICT   = 2

@implementation DictionaryStack {

    NSMutableArray *stack;

    NSDictionary *systemDict;

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
        stack = [[NSMutableArray alloc] initWithCapacity:5];
        [stack addObject:systemDict];
    }
    return self;
}

# pragma mark - Dictionary Methods

@end
