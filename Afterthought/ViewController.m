//
//  ViewController.m
//  Afterthought
//
//  Created by Esteban Valle on 11/20/16.
//  Copyright © 2016 TVD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {

    /// Interpreter Fields
    Tokenizer *parser;

    /// Stacks
    OperandStack *operandStack;
    DictionaryStack *dictionaryStack;

}

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    /// Set up the Stacks
    operandStack = [OperandStack getInstance];
    dictionaryStack = [DictionaryStack getInstance];

    parser = [[Tokenizer alloc] init];

    NSString *file = [[NSBundle mainBundle] pathForResource:@"string_funcs"
                                                     ofType:@"txt"];

    [parser loadFile:file];

    Token *token = [parser nextToken];

    SystemExecutionBlock runBlock;

    while (token){

        switch (token.tokenType) {
            case Bool:
            case Integer:
            case Literal:
            case Real:
            case Block:
            case Array:
            case String:
            case Mark:
            case Dictionary:
                [operandStack pushToken:token];
                break;

            case Executable:
                // look up the executable in the dictionary stack
                // and follow the commands in that stack
                runBlock = [dictionaryStack blockForExecutable:token];
                if (runBlock) {
                    runBlock();
                }
                break;

        }

        token = [parser nextToken];
    }

    NSLog(@"Stack:\n %@", operandStack);

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
