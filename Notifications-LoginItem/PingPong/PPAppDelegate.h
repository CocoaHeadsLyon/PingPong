//
//  PPAppDelegate.h
//  PingPong
//
//  Created by Thibaut Jarosz on 17/01/2013.
//  Copyright (c) 2013 Octiplex. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PPAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSTextField *pingLabel;
@property (weak) IBOutlet NSTextField *helperLabel;

- (IBAction)ping:(id)sender;
- (IBAction)helperStatus:(id)sender;
- (IBAction)startHelper:(id)sender;
- (IBAction)stopHelper:(id)sender;

@end
