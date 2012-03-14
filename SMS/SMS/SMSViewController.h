//
//  SMSViewController.h
//  SMS
//
//  Created by Robby Kraft on 12/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//
//  SMS Sending tutorial
//  http://www.youtube.com/watch?v=ZKmrp30IPN4
//  

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface SMSViewController : UIViewController <MFMessageComposeViewControllerDelegate> {

    IBOutlet UILabel *feedbackmessage;  //SendSMS
    IBOutlet UITextView *messagetosend; //SendSMS
    IBOutlet UITextView *phoneNumbers;  //SendSMS
    IBOutlet UITextView *emailAddresses;//SendEMAIL
}

@property (nonatomic, retain) IBOutlet UILabel *feedbackmessage;   //SendSMS
@property (nonatomic, retain) IBOutlet UITextView *messagetosend;  //SendSMS/EMAIL
@property (nonatomic, retain) IBOutlet UITextView *phoneNumbers;   //SENDSMS
@property (nonatomic, retain) IBOutlet UITextView *emailAddresses; //SendEMAIL

- (IBAction) sendSMS;  //SendSMS
- (IBAction) sendEmail; //SendEmail

@end