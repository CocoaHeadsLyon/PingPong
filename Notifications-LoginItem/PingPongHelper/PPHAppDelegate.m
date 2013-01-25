//
//  PPHAppDelegate.m
//  PingPongHelper
//
//  Created by Thibaut Jarosz on 17/01/2013.
//  Copyright (c) 2013 Octiplex. All rights reserved.
//

#import "PPHAppDelegate.h"

@implementation PPHAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(ping:) name:@"PingPong-Ping" object:nil];

}

- (void)ping:(NSNotification*)notification
{
    // Forward userInfo into Pong response
    [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"PingPong-Pong" object:nil userInfo:notification.userInfo deliverImmediately:YES];
}

@end
