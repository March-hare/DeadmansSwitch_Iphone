//
//  TimerViewController.m
//  Timer
//
//  Created by Robby Kraft on 12/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TimerViewController.h"

@implementation TimerViewController

@synthesize start;
@synthesize status;

-(IBAction)openSettings:(id)sender{
    SettingsViewController *settings = [[SettingsViewController alloc] init];
    [[self navigationController] pushViewController:settings animated:YES];
    [settings release];
}

-(IBAction)bigButton
{
    if(firstRun == false){
        [self beginTimer];
        firstRun = true;
    }
    else if(firstRun == true){
        [self keepGoing];
    }
}

-(void)beginTimer
{
    status.textColor = [[UIColor alloc] initWithWhite:.4 alpha:1];
    status.text = @"active";
    [self performSelector:@selector(deadman) withObject:nil afterDelay:5];
    //NSLog(@"ACTIVE");
}

-(void)keepGoing
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(deadman) object:nil];
    [self performSelector:@selector(deadman) withObject:nil afterDelay:5];
}

-(void) deadman
{
    //NSLog(@"EXPIRED");
    status.textColor = [[UIColor alloc] initWithRed:.7 green:0 blue:0 alpha:1];
    status.text = @"expired";
    firstRun = false;
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
    firstRun = false;
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
