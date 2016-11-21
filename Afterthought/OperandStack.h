//
//  OperandStack.h
//  Afterthought
//
//  Created by Esteban Valle on 11/20/16.
//  Copyright © 2016 TVD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Token.h"

@interface OperandStack : NSObject

+ (OperandStack *)getInstance;

- (Token *)peek;
- (Token *)pop;

- (void)pushToken:(Token *)token;
- (NSInteger)size;
- (Token *)tokenAtPosition:(NSInteger)index;


@end
