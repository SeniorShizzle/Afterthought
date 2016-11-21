//
//  DictionaryStack.h
//  Afterthought
//
//  Created by Esteban Valle on 11/21/16.
//  Copyright © 2016 TVD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Token.h"

@interface DictionaryStack : NSObject {

}

+ (DictionaryStack *) getInstance;

- (void) setToken:(Token *)value forKey:(Token *)key;

@end
