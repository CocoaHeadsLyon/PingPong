//
//  PPResponderProtocol.h
//  PingPong
//
//  Created by Thibaut Jarosz on 25/01/2013.
//  Copyright (c) 2013 Octiplex. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PPResponderProtocol <NSObject>

- (void)performPingWithResultBlock:(void (^)())resultBlock;

@end
