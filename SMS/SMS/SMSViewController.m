//
//  SMSViewController.m
//  SMS
//
//  Created by Robby Kraft on 12/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SMSViewController.h"
#import <MessageUI/MessageUI.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@implementation SMSViewController

@synthesize feedbackmessage;
@synthesize messagetosend;
@synthesize emailAddresses;
@synthesize phoneNumbers;

- (IBAction) sendSMS
{    
    MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
    if([MFMessageComposeViewController canSendText]){
        controller.body = messagetosend.text;
        controller.recipients = [NSArray arrayWithObjects:@"9407651810", nil];
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }
    
}

#pragma mark -
#pragma mark Dismiss Mail/SMS view controller

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    
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
}

- (IBAction) sendEmail{
    
/*    MFMailComposeViewController *mailComposer; 
    mailComposer  = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = self;
    [mailComposer setModalPresentationStyle:UIModalPresentationFormSheet];
    [mailComposer setSubject:@"your custom subject"];
    [mailComposer setMessageBody:@"your custom body content" isHTML:NO];
    [self presentModalViewController:mailComposer animated:YES];
    [mailComposer release];    
*/
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
