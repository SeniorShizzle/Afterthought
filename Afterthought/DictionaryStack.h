//
//  DictionaryStack.h
//  Afterthought
//
//  Created by Esteban Valle on 11/21/16.
//  Copyright © 2016 TVD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Token.h"

typedef void (^SystemExecutionBlock)(void);

@interface DictionaryStack : NSObject {

}

+ (DictionaryStack *) getInstance;

- (void) setToken:(Token *)value forKey:(Token *)key;

- (void) addUserDictionaryToStack:(NSDictionary *)userDict;

- (SystemExecutionBlock) blockForExecutable:(Token *) executable;

- (Token *) tokenForKey:(Token *)key;


@end
