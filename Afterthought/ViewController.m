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
    ExecutionStack *execStack;

}

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    /// Set up the Stacks
    execStack = [ExecutionStack getInstance];

    parser = [[Tokenizer alloc] init];

    NSString *file = [[NSBundle mainBundle] pathForResource:@"dicttest"
                                                     ofType:@"txt"];

    [parser loadFile:file];
    [execStack pushContext:parser];
    [execStack run];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
