//
//  SMSAppDelegate.h
//  SMS
//
//  Created by Robby Kraft on 12/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMSViewController;

@interface SMSAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet SMSViewController *viewController;

@end
