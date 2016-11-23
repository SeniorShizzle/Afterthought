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

@interface Token : NSObject <NSCopying> {

}

@property (nonatomic, readonly) TokenType tokenType;
@property (nonatomic, readonly) NSObject * value;

+ (Token *) tokenFromString:(NSString *)string;
+ (Token *) mark;
+ (Token *) tokenWithInteger:(NSInteger)integer;
+ (Token *) tokenWithReal:(NSNumber *)real;
+ (Token *) tokenWithBool:(bool)boolean;
+ (Token *) tokenWithExecutable:(NSString *)executable;
+ (Token *) tokenWithString:(NSString *)string;

+ (NSString *) tokenTypeString:(TokenType)type;

- (NSComparisonResult) compareTo:(Token *)other;

@end
