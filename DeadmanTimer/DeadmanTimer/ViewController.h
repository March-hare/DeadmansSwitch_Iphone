//
//  ViewController.h
//  DeadmanTimer
//
//  Created by Dann Stayskal on 12/20/11.
//  Copyright (c) 2011 COPIOUS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (retain) UIButton *start;
@property (assign) UILabel IBOutlet *status;

-(IBAction)buttonPressed:(id)sender;
-(IBAction)keepGoing:(id)sender;

@end
