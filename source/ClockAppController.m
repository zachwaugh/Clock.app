//
//  AppController.m
//  Clock
//
//  Created by Zach Waugh on 2/15/08.
//  Copyright 2008 zachwaugh.com. All rights reserved.
//

#import "ClockAppController.h"
#import "ClockView.h"
#import "ClockWindow.h"

// Private methods
@interface ClockAppController ()

- (void)tick:(NSTimer *)aTimer;
- (void)startClock;
- (void)stopClock;

@end


@implementation ClockAppController

@synthesize clockView, clockWindow, timer;


- (void)awakeFromNib
{	
	[self startClock];
}


- (void)tick:(NSTimer *)aTimer
{
	[self.clockView setNeedsDisplay:YES];
}


- (void)startClock
{
	self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(tick:) userInfo:NULL repeats:YES];
}


- (void)stopClock
{
	[self.timer invalidate];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification
{
	// Probably don't really need to do this, but it's good to clean up after ourselves
	[self stopClock];
}


@end
