//
//  ViewController.m
//  Forth Sample
//
//  Created by Hinh Tinh Thach on 29/10/15.
//  Copyright © 2015 Fort TV. All rights reserved.
//

#import "ViewController.h"
#import "DemoView.h"
@interface ViewController ()
@property (nonatomic, strong) DemoView *demoView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect demoFrame = CGRectMake(10, 10, _container.frame.size.width - 20, _container.frame.size.height - 20);
    
    self.demoView = [[DemoView alloc] initWithFrame:demoFrame];
    self.demoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.container addSubview:self.demoView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonDidPress:(UIButton *)sender {
    //show whatever text in the text field to label, and print to console
    NSString *stringToPrint = self.textField.text;
    
    //show on label
    self.label.text = stringToPrint;
    
    //log to console
    NSLog(@"log string to log %@", stringToPrint);
    
}

- (IBAction)textFieldDidEnd:(UITextField *)sender {
    //finished editing text
}
@end
