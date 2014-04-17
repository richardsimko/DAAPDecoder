//
//  URAppDelegate.m
//  DAAPDecoder
//
//  Created by Rick on 2014-04-17.
//  Copyright (c) 2014 Rick. All rights reserved.
//

#import "URAppDelegate.h"
#import "URDAAPDecoder.h"

@implementation URAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [URDAAPDecoder new];
    exit(0);
}

@end
