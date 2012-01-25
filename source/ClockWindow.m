//
//  ClockWindow.m
//  Clock
//
//  Created by Zach Waugh on 2/15/08.
//  Copyright 2008 zachwaugh.com. All rights reserved.
//

#import "ClockWindow.h"

@implementation ClockWindow


- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag 
{	
	NSWindow *result = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO];
	
	[result setBackgroundColor:[NSColor clearColor]];
	[result setLevel:NSStatusWindowLevel];
	[result setAlphaValue:1.0];
	[result setOpaque:NO];
	[result setHasShadow:NO];
	[result setMovableByWindowBackground:YES];
	
	return result;
}

- (void)cancelOperation:(id)sender
{
    [NSApp terminate: nil];
}

- (BOOL)canBecomeKeyWindow
{
	return YES;
}


@end
