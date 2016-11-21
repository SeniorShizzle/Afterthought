//
//  Token.h
//  Afterthought
//
//  Created by Esteban Valle on 11/20/16.
//  Copyright © 2016 TVD. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TokenType){
    Block,
    Integer,
    Real,
    Executable,
    String,
    Literal,
    Array,
    Bool,
    Dictionary,
    Mark
};

@interface Token : NSObject {

}

@property (nonatomic, readonly) TokenType tokenType;
@property (nonatomic, readonly) NSObject * value;

+ (Token *) tokenFromString:(NSString *)string;
+ (Token *) mark;
+ (NSString *) tokenTypeString:(TokenType)type;

@end
