//
//  TimerAppDelegate.h
//  Timer
//
//  Created by Robby Kraft on 12/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TimerViewController;

@interface TimerAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TimerViewController *viewController;

@end
