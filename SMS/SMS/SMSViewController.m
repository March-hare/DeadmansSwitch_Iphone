//
//  SMSViewController.m
//  SMS
//
//  Created by Robby Kraft on 12/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SMSViewController.h"

@implementation SMSViewController

////////////////////
// SendSMS

@synthesize feedbackmessage;
@synthesize messagetosend;

- (IBAction) sendSMS{
    
    MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
    if([MFMessageComposeViewController canSendText]){
        controller.body = messagetosend.text;
        //controller.body = @"Text Message Body";
        controller.recipients = [NSArray arrayWithObject:nil];
        controller.messageComposeDelegate = self;
        [self presentModalViewController:self animated:YES];
    }
    
}

#pragma mark -
#pragma mark Dismiss Mail/SMS view controller

-(void) messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
    switch (result) {
        case MessageComposeResultCancelled:
            feedbackmessage.text = @"SMS sending cancelled";
            break;
        case MessageComposeResultSent:
            feedbackmessage.text = @"SMS sent";
            break;
        case MessageComposeResultFailed:
            feedbackmessage.text = @"SMS sending failed";
            break;            
        default:
            feedbackmessage.text = @"SMS not sent";
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
}

// SendSMS
////////////////////////

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
