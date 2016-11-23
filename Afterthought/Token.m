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

# pragma mark - Initializers 


+ (Token *) mark {
    return [[Token alloc] initMark];
}

+ (Token *) tokenFromString:(NSString *)string {
    return [[Token alloc] initFromString:string];
}

+ (Token *) tokenWithBool:(bool)boolean {
    return [[Token alloc] initWithType:Bool andValue:[NSNumber numberWithBool:boolean]];
}

+ (Token *) tokenWithReal:(NSNumber *)real {
    return [[Token alloc] initWithType:Real andValue:real];
}

+ (Token *) tokenWithExecutable:(NSString *)executable {
    return [[Token alloc] initWithType:Executable andValue:executable];
}

+ (Token *)tokenWithInteger:(NSInteger)integer {
    return [[Token alloc] initWithType:Integer andValue:[NSNumber numberWithInteger:integer]];
}

+ (Token *)tokenWithString:(NSString *)string {
    return [[Token alloc] initWithType:String andValue:string];
}


# pragma mark - Private Initializers

- (Token *) initMark{
    self = [super init];

    if (!self) return NULL;

    _value = @"- mark -";
    _tokenType = Mark;

    return self;
}

- (Token *) initWithType:(TokenType)type andValue:(NSObject *)value{
    self = [super init];

    if (!self) return NULL;

    _value = value;
    _tokenType = type;

    return self;
}



- (Token *) initFromString:(NSString *)string {

    self = [super init];

    if (!self) return NULL;

    if (!string) return NULL;

    if ([string characterAtIndex:0] == '{'){
        _tokenType = Block;
        _value = [string substringWithRange:NSMakeRange(1, [string length] - 2)];

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
        _value = [string substringWithRange:NSMakeRange(1, [string length] - 2)];

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

    if ([string compare:@"mark"] == NSOrderedSame){
        _tokenType = Mark;
        _value = @"- mark -";

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

- (NSComparisonResult)compareTo:(Token *)other {
    // okay... we're going to have to decide the ordination between abritrary things

    if (_tokenType != other.tokenType) return NSOrderedSame; // level the playing field

    NSNumber *left;
    NSNumber *right;

    NSString *leftS;
    NSString *rightS;

    switch (other.tokenType) {
        case Block:
        case Executable:
        case Literal:
        case Array:
        case Bool:
        case Dictionary:
        case Mark:
            return NSOrderedSame;

        case Integer:
        case Real:

            left  = (NSNumber *)_value;
            right = (NSNumber *)other.value;

            return left > right ? NSOrderedAscending : NSOrderedDescending;

        case String:

            leftS = (NSString *)_value;
            rightS = (NSString *)other.value;

            return [leftS compare:rightS];
    }

}

- (BOOL)isEqual:(id)object {
    if ([object class] != [self class]) return NO;

    Token *token = (Token *)object;

    return token.tokenType == _tokenType && [token.value isEqual:_value];
}

- (NSUInteger)hash {
    return _tokenType;
}

- (id)copyWithZone:(NSZone *)zone {
    return [[Token alloc] initWithType:_tokenType andValue:[_value copy]];
}

- (NSString *) descriptionForStack {
    NSString *retString = [self description]; //[NSString stringWithFormat:@"%@", [_value description], [Token tokenTypeString:_tokenType]];

    retString = [retString stringByPaddingToLength:40 withString:@" " startingAtIndex:0];
    retString = [retString stringByAppendingString:[NSString stringWithFormat:@"(%@)", [Token tokenTypeString:_tokenType]]];
    return retString;
}

- (NSString *) description {

    if (_tokenType == Bool) return [(NSNumber *)_value boolValue] ? @"True" : @"False";

    NSString *retString = [_value description];
    retString = [retString stringByReplacingOccurrencesOfString:@"\n" withString:@""];

    if ([retString length] > 40){
        retString = [NSString stringWithFormat:@"---- %@ Too Long ----", [Token tokenTypeString:_tokenType]];
    }

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
