//
//  main.m
//  PingPongXPC
//
//  Created by Thibaut Jarosz on 25/01/2013.
//  Copyright (c) 2013 Octiplex. All rights reserved.
//

#include <Foundation/Foundation.h>
#import "PPXResponder.h"

int main(int argc, const char *argv[])
{
    NSXPCListener *serviceListener = [NSXPCListener serviceListener];
    serviceListener.delegate = [PPXResponder sharedInstance]; // Use a shared instace to prevent object from being deleted (side effect due to ARC)
    
    [serviceListener resume]; // resume never returns
    
    
	return 0;
}
