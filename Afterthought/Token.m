//
//  Token.m
//  Afterthought
//
//  Created by Esteban Valle on 11/20/16.
//  Copyright © 2016 TVD. All rights reserved.
//

#import "Token.h"

@implementation Token {

}

@synthesize tokenType = _tokenType;
@synthesize value = _value;



+ (Token *)mark {
    return [[Token alloc] initMark];
}


+ (Token *)tokenFromString:(NSString *)string {
    return [[Token alloc] initFromString:string];
}


- (Token *) initMark{
    self = [super init];

    if (!self) return NULL;

    _value = NULL;
    _tokenType = Mark;

    return self;
}



- (Token *) initFromString:(NSString *)string {

    self = [super init];

    if (!self) return NULL;

    if (!string) return NULL;

    if ([string characterAtIndex:0] == '{'){
        _tokenType = Block;
        _value = string;

        return self;
    }

    if ([string characterAtIndex:0] == '('){
        _tokenType = String;
        _value = [string substringWithRange:NSMakeRange(1, [string length] - 2)];

        return self;
    }

    if ([string characterAtIndex:0] == '/'){
        _tokenType = Literal;
        _value = [string substringFromIndex:1];

        return self;
    }

    if ([string characterAtIndex:0] == '<'){
        _tokenType = Array;
        _value = string;

        return self;
    }

    if ([string compare:@"true"] == NSOrderedSame){
        _tokenType = Bool;
        _value = @YES;

        return self;
    }

    if ([string compare:@"false"] == NSOrderedSame){
        _tokenType = Bool;
        _value = @NO;

        return self;
    }

    if ([string containsString:@"."]){

        /// Check for Reals
        float floatVal = [string floatValue];

        if (floatVal != 0.0) {
            _value = [NSNumber numberWithFloat:floatVal];
            _tokenType = Real;

            return self;
        } else {
            // Ensure the string itself was actually "0.0..."
            if ([[string substringWithRange:NSMakeRange(0, 2)] compare:@"0.0"] == NSOrderedSame) {
                _value = @0.0;
                _tokenType = Real;
                return self;
            }
        }

    } else {

        /// Check for Integers
        NSInteger intVal = [string integerValue];

        if (intVal != 0) {
            _value = [NSNumber numberWithInteger:intVal];
            _tokenType = Integer;

            return self;
        } else {
            // Ensure the string itself was actually "0.0..."
            if ([string characterAtIndex:0] == '0') {
                _value = @0;
                _tokenType = Integer;
                return self;
            }
        }
    }



    /// Assume it is an executable then
    _tokenType = Executable;
    _value = string;

    return self;
}


# pragma mark - Helper Methods

- (NSString *) description {
    NSString *retString = [_value description]; //[NSString stringWithFormat:@"%@", [_value description], [Token tokenTypeString:_tokenType]];
    retString = [retString stringByReplacingOccurrencesOfString:@"\n" withString:@""];

    if ([retString length] > 40){
        retString = [NSString stringWithFormat:@"---- %@ Too Long ----", [Token tokenTypeString:_tokenType]];
    }

    retString = [retString stringByPaddingToLength:40 withString:@" " startingAtIndex:0];
    retString = [retString stringByAppendingString:[NSString stringWithFormat:@"(%@)", [Token tokenTypeString:_tokenType]]];
    return retString;
}


+ (NSString *) tokenTypeString:(TokenType)type {
    switch (type) {
        case Bool:
            return @"Boolean";
        case Block:
            return @"Code Block";
        case Integer:
            return @"Integer";
        case Real:
            return @"Real";
        case Executable:
            return @"Executable";
        case String:
            return @"String";
        case Literal:
            return @"Literal";
        case Array:
            return @"Array";
        case Dictionary:
            return @"Dictionary";
        case Mark:
            return @"Mark";

        default:
            return @"Unknown Type";
    }
}



@end
