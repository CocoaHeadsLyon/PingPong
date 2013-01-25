//
//  PPAppDelegate.m
//  PingPong
//
//  Created by Thibaut Jarosz on 17/01/2013.
//  Copyright (c) 2013 Octiplex. All rights reserved.
//

#import "PPAppDelegate.h"
#import <ServiceManagement/ServiceManagement.h>

@implementation PPAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(pong:) name:@"PingPong-Pong" object:nil];
    self.pingLabel.stringValue = @"";
    self.helperLabel.stringValue = @"";
}

- (IBAction)ping:(NSButton *)sender
{
    self.pingLabel.stringValue = @"ping…";
    [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"PingPong-Ping"
                                                                   object:nil
                                                                 userInfo:@{ @"number" : @(CFAbsoluteTimeGetCurrent()) }
                                                       deliverImmediately:YES];
}

- (void)pong:(NSNotification*)notification
{
    NSNumber *number = notification.userInfo[@"number"];
    CFAbsoluteTime intervale = CFAbsoluteTimeGetCurrent() - [number doubleValue];
    self.pingLabel.stringValue = number ? [NSString stringWithFormat:@"pong = %f", intervale] : @"pong = error";
}


#pragma mark - Helper status

- (IBAction)startHelper:(id)sender
{
    [self setAppInLoginItems:YES];
}

- (IBAction)stopHelper:(id)sender
{
    [self setAppInLoginItems:NO];
}

- (IBAction)helperStatus:(id)sender
{
    self.helperLabel.stringValue = self.isAppInLoginItems ? @"Helper installed" : @"Helper not installed";
}

- (BOOL)isAppInLoginItems
{
    // Get Helper bundle ID
    NSString *bundleID = [[self loginItemAppBundle] bundleIdentifier];
    
    // Get list of all installed login items
    NSArray * jobDicts = (__bridge_transfer NSArray *)SMCopyAllJobDictionaries( kSMDomainUserLaunchd ); // Requires ServiceManagement framework
    
    
    for ( NSDictionary * job in jobDicts )
        if ( [bundleID isEqualToString:[job objectForKey:@"Label"]] ) // If login item is helper
            return [[job objectForKey:@"OnDemand"] boolValue]; // Helper is installed if OnDemand is at YES.
    
    return NO;
}

- (BOOL)setAppInLoginItems:(BOOL)appInLoginItems
{
    // This is the only solution if sandboxing is enabled
    return SMLoginItemSetEnabled((__bridge CFStringRef)[[self loginItemAppBundle] bundleIdentifier], appInLoginItems); // Requires ServiceManagement framework
}

- (NSBundle *)loginItemAppBundle
{
    // Return the bundle ID of the Helper
    static NSBundle *loginItemAppBundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginItemAppBundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Contents/Library/LoginItems/PingPongHelper.app"]];
    });
    return loginItemAppBundle;
}


@end
