//
//  TimerViewController.m
//  Timer
//
//  Created by Robby Kraft on 12/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TimerViewController.h"
#import "SMTPSenderAppDelegate.h"
#import "SMTPSenderViewController.h"
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"


@implementation TimerViewController

@synthesize start;
@synthesize status;
@synthesize status2;
@synthesize delayTime;

-(IBAction)bigButton
{
    if(firstRun == FALSE){
        [self checkIn:TRUE];
        firstRun = TRUE;
    }
    else if(firstRun == TRUE){
        [self checkIn:FALSE];
    }
}

-(void)checkIn:(BOOL)firstTime
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"operationalstatus"];
    [defaults synchronize];

    downSMS = [defaults stringForKey:@"downMessage"];
    phoneNumbers = [defaults stringArrayForKey:@"contactList"];
    delayTime = [defaults integerForKey:@"settings_timer"];

    if(firstTime){
        status.textColor = [[UIColor alloc] initWithRed:.7 green:.7 blue:0 alpha:1];
        status.text = @"Initializing";
        status2.textColor = [[UIColor alloc] initWithWhite:.4 alpha:1];
        status2.text = [NSString stringWithFormat:@"check in interval: %i min",delayTime];
        [self performSelector:@selector(fadetext) withObject:nil afterDelay:2];
    }
    if(!firstTime){
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(deadman) object:nil];
    }
    [self performSelector:@selector(deadman) withObject:nil afterDelay:delayTime*60];
}

-(void)fadetext
{
    status.textColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0];
    status2.textColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0];
}

-(void) deadman
{
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //BOOL opStatus = ;

    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"operationalstatus"] == TRUE){
        status.textColor = [[UIColor alloc] initWithRed:.7 green:0 blue:0 alpha:1];     
        status.text = @"executing..";
    }
    else if([[NSUserDefaults standardUserDefaults] boolForKey:@"operationalstatus"] == FALSE){
        status.textColor = [[UIColor alloc] initWithRed:0 green:0 blue:.7 alpha:1];
        status.text = @"Safely Disarmed";
    }
    firstRun = FALSE;
    [self performSelector:@selector(fadetext) withObject:nil afterDelay:2];
    [self sendSMS];
    [self sendSMTP];
}

- (void) sendSMS
{    
    MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
    if([MFMessageComposeViewController canSendText]){
        controller.body = downSMS;
        controller.recipients = phoneNumbers;//[NSArray arrayWithObjects:@"9407651810", nil];
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }
    
}

- (void) sendSMTP
{
    // replace "..." with email
    // fill in password
    SKPSMTPMessage *downMsg = [[SKPSMTPMessage alloc] init];
    downMsg.fromEmail = @"...@gmail.com";
    downMsg.toEmail = @"...@gmail.com";
    downMsg.relayHost = @"smtp.gmail.com";
    downMsg.requiresAuth = YES;
    downMsg.login = @"...@gmail.com";
    downMsg.pass = @"";
    downMsg.subject = @"Deadman Switch delivery note";
    //downMsg.bccEmail = @"testbcc@test.com";
    downMsg.wantsSecure = YES; // smtp.gmail.com doesn't work without TLS!
    
    // Only do this for self-signed certs!
    // downMsg.validateSSLChain = NO;
    downMsg.delegate = self;
    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
                               @"Your friend hasn't checked in",kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    
    /*NSString *vcfPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"vcf"];
    NSData *vcfData = [NSData dataWithContentsOfFile:vcfPath];
    
    NSDictionary *vcfPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/directory;\r\n\tx-unix-mode=0644;\r\n\tname=\"test.vcf\"",kSKPSMTPPartContentTypeKey,
                             @"attachment;\r\n\tfilename=\"test.vcf\"",kSKPSMTPPartContentDispositionKey,[vcfData encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
    */
    downMsg.parts = [NSArray arrayWithObjects:plainPart,nil];
    
    [downMsg send];

}

- (void)messageSent:(SKPSMTPMessage *)message
{
    [message release];
    
    NSLog(@"delegate - message sent");
}

- (void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error
{
    [message release];
    
    NSLog(@"delegate - error(%d): %@", [error code], [error localizedDescription]);
}


#pragma mark -
#pragma mark Dismiss Mail/SMS view controller

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    
    switch (result) {
        case MessageComposeResultCancelled:
            //feedbackmessage.text = @"SMS sending cancelled";
            break;
        case MessageComposeResultSent:
            //feedbackmessage.text = @"SMS sent";
            break;
        case MessageComposeResultFailed:
            //feedbackmessage.text = @"SMS sending failed";
            break;            
        default:
            //feedbackmessage.text = @"SMS not sent";
            break;
    }
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    firstRun = FALSE;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:@"operationalstatus"];
    [defaults synchronize];
    downMessage = [[NSUserDefaults standardUserDefaults] stringForKey:@"downMessage"];
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
