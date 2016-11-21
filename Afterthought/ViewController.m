//
//  ViewController.m
//  Afterthought
//
//  Created by Esteban Valle on 11/20/16.
//  Copyright © 2016 TVD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {

    Tokenizer *parser;
    OperandStack *operandStack;

}

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    operandStack = [OperandStack getInstance];

    parser = [[Tokenizer alloc] init];

    NSString *file = [[NSBundle mainBundle] pathForResource:@"project_test_symbols"
                                                     ofType:@"txt"];

    [parser loadFile:file];

    Token *token = [parser nextToken];

    while (token){

        switch (token.tokenType) {
            case Bool:
            case Integer:
            case Literal:
            case Real:
            case Block:
            case Array:
            case String:
            case Dictionary:
                [operandStack pushToken:token];
                break;

            case Executable:
                // look up the executable in the dictionary stack
                // and follow the commands in that stack
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
