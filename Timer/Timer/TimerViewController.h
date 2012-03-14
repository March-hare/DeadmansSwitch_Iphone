//
//  TimerViewController.h
//  Timer
//
//  Created by Robby Kraft on 12/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <CFNetwork/CFNetwork.h>

#import "SKPSMTPMessage.h"

@interface TimerViewController : UIViewController <MFMessageComposeViewControllerDelegate, SKPSMTPMessageDelegate> {
    BOOL firstRun;
    int delayTime;
    NSArray *phoneNumbers;
    NSString *downSMS;
    NSString *downMessage;
}
@property (assign) UIButton *start;
@property (assign) UILabel IBOutlet *status;
@property (assign) UILabel IBOutlet *status2;
@property (assign) int delayTime;

-(void)checkIn:(BOOL)firstTime;
-(void)fadetext;
-(void)sendSMS;
-(void)sendSMTP;
-(IBAction)bigButton;

@end
