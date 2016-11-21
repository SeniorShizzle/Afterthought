//
//  Tokenizer.h
//  Afterthought
//
//  Created by Esteban Valle on 11/20/16.
//  Copyright © 2016 TVD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Token.h"

@interface Tokenizer : NSObject

- (void) loadFile:(NSString *)filePath;

- (Token *) nextToken;

@end
