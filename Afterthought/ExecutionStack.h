//
//  ExecutionStack.h
//  Afterthought
//
//  Created by Esteban Valle on 11/22/16.
//  Copyright © 2016 TVD. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Token.h"
#import "Tokenizer.h"

@interface ExecutionStack : NSObject {



}

+ (ExecutionStack *) getInstance;

- (void) popAndResumeExecution;
- (void) pushContext:(Tokenizer *)context;

@end
