//
//  Tokenizer.m
//  Afterthought
//
//  Created by Esteban Valle on 11/20/16.
//  Copyright © 2016 TVD. All rights reserved.
//

#import "Tokenizer.h"

@implementation Tokenizer {

    NSString *fileText;
    NSInteger filePosition;

}

# pragma mark - Setup Methods

- (void) loadFile:(NSString *)filePath {

    @try {
        fileText = [NSString stringWithContentsOfFile:filePath
                                             encoding:NSUTF8StringEncoding
                                                error:NULL];
    } @catch (NSException *exception) {
        NSLog(@"Error opening file %@:\n\t%@", filePath, exception.description);

        return;
    }


    filePosition = 0;
}

- (void) loadString:(NSString *)string {

    fileText = string;
    filePosition = 0;

}

- (void) loadBlockInToken:(Token *)token {
    if (token.tokenType != Block) {
        [NSException raise:@"Illegal Executable Type" format:@"Attempted to parse a non-block literal"];
    }

    fileText = (NSString *)token.value;

    filePosition = 0;
}

# pragma mark - Tokenizer

- (Token *) nextToken {
    if (!fileText || filePosition >= [fileText length]) return NULL;

    unichar currentCharacter = ' ';


    while (filePosition < [fileText length] && (currentCharacter == ' ' || currentCharacter == '\n')){
        currentCharacter = [fileText characterAtIndex:filePosition];
        filePosition++; // find the first non-space character
    }

    if (filePosition >= [fileText length]) return NULL; // exit if we've reached EOF

    filePosition--;

    NSInteger initialPosition = filePosition;
    NSInteger blockCount = 0;
    NSString *tokenString;

    switch (currentCharacter) {
        case '%':
            // Scan to the next newline then re-process
            while (filePosition < [fileText length] && [fileText characterAtIndex:filePosition] != '\n'){
                filePosition++; // find the first non-space character
            }
            filePosition++;
            return [self nextToken];

        case '{':
            // Scan until we find the closing bracket
            while (filePosition < [fileText length]){

                currentCharacter = [fileText characterAtIndex:filePosition];

                if (currentCharacter == '{') {
                    blockCount++;
                }

                if (currentCharacter == '}') {
                    blockCount--;
                }

                if (blockCount == 0) {
                    break;
                }

                filePosition++; // find the first non-space character
            }
            // we've now found the closer to this block, so let's substring
            filePosition++;
            break;

        case '(':
            while (filePosition < [fileText length]){

                currentCharacter = [fileText characterAtIndex:filePosition];

                if (currentCharacter == '(') {
                    blockCount++;
                }

                if (currentCharacter == ')') {
                    blockCount--;
                }

                if (blockCount == 0) {
                    break;
                }

                filePosition++; // find the first non-space character
            }
            // we've now found the closer to this block, so let's substring
            filePosition++;
            break;

        case '/':
        default:
            while (filePosition < [fileText length] && currentCharacter != ' ' && currentCharacter != '\n'){
                currentCharacter = [fileText characterAtIndex:filePosition];
                filePosition++; // find the first non-space character
            }

            filePosition--; // one space back to account for the non-whitespace character we landed on
            
            break;
    }

    // We should now have loaded up 'tokenString' with the token
    tokenString = [fileText substringWithRange:NSMakeRange(initialPosition, filePosition - initialPosition)];

    return [Token tokenFromString:tokenString];
}

@end
