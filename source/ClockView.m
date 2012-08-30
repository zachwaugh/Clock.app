//
//  ClockView.m
//  Clock
//
//  Created by Zach Waugh on 2/15/08.
//  Copyright 2008 zachwaugh.com. All rights reserved.
//

#import "ClockView.h"

#define RADIUS 25

@implementation ClockView

// Allow for transparency
- (BOOL)isOpaque
{
	return NO;
}

- (void)drawRect:(NSRect)rect 
{
	[[NSColor colorWithCalibratedWhite:0 alpha:0.5] set];
	[[NSBezierPath bezierPathWithRoundedRect:self.bounds xRadius:RADIUS yRadius:RADIUS] fill];
}

@end
