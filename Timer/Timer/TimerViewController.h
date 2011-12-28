//
//  TimerViewController.h
//  Timer
//
//  Created by Robby Kraft on 12/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"

@interface TimerViewController : UIViewController {
    BOOL firstRun;
}

@property (assign) UIButton *start;
@property (assign) UILabel IBOutlet *status;

-(void)beginTimer;
-(void)keepGoing;
-(IBAction)bigButton;

@end
