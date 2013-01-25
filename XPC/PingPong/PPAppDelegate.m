//
//  PPAppDelegate.m
//  PingPong
//
//  Created by Thibaut Jarosz on 17/01/2013.
//  Copyright (c) 2013 Octiplex. All rights reserved.
//

#import "PPAppDelegate.h"
#import "PPResponderProtocol.h"

@implementation PPAppDelegate
{
    id _remoteObjectProxy;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    NSXPCConnection *connection = [[NSXPCConnection alloc] initWithServiceName:@"com.octiplex.PingPongXPC"];
    connection.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(PPResponderProtocol)];
    [connection resume];
    
    _remoteObjectProxy = [connection remoteObjectProxyWithErrorHandler:^(NSError *error) {
        // WARNING: block is executed in secondary thread
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%s error = %@", __PRETTY_FUNCTION__, error);
            self.pingLabel.stringValue = @"pong = error (see log file for more information)";
        });
        
    }];
}


- (IBAction)ping:(NSButton *)sender
{
    self.pingLabel.stringValue = @"ping…";
    CFAbsoluteTime time = CFAbsoluteTimeGetCurrent();
    
    [_remoteObjectProxy performPingWithResultBlock:^{
        // WARNING: block is executed in secondary thread
        
        dispatch_async(dispatch_get_main_queue(), ^{
            CFAbsoluteTime intervale = CFAbsoluteTimeGetCurrent() - time;
            self.pingLabel.stringValue = [NSString stringWithFormat:@"pong = %f", intervale];
        });
        
    }];
}

@end
