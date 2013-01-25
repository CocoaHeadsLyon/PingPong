//
//  PPXResponder.m
//  PingPong
//
//  Created by Thibaut Jarosz on 25/01/2013.
//  Copyright (c) 2013 Octiplex. All rights reserved.
//

#import "PPXResponder.h"

@implementation PPXResponder

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

- (BOOL)listener:(NSXPCListener *)listener shouldAcceptNewConnection:(NSXPCConnection *)newConnection
{
    newConnection.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(PPResponderProtocol)];
    newConnection.exportedObject = self;
    [newConnection resume];
    return YES;
}

- (void)performPingWithResultBlock:(void (^)())resultBlock
{
    // Uncomment the following to simulate delay in ping response
    
    //    int64_t delayInSeconds = 2.0;
    //    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    //    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    resultBlock();
    //    });
}

@end
