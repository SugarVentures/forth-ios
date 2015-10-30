//
//  ViewController.h
//  Forth Sample
//
//  Created by Hinh Tinh Thach on 29/10/15.
//  Copyright © 2015 Fort TV. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SampleDelegate <NSObject>

-(void) delegateCallBack;

@end

@interface ViewController : UIViewController
@property (weak) id<SampleDelegate> myDelegate;

@property (weak, nonatomic) IBOutlet UITextField    *textField;
@property (weak, nonatomic) IBOutlet UILabel        *label;
@property (weak, nonatomic) IBOutlet UIButton       *button;

@property (weak, nonatomic) IBOutlet UIView         *container;
- (IBAction)buttonDidPress:(UIButton *)sender;
- (IBAction)textFieldDidEnd:(UITextField *)sender;
@end

