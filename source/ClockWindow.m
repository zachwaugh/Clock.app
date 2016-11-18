//
//  ClockWindow.m
//  Clock
//
//  Created by Zach Waugh on 2/15/08.
//  Copyright 2008 zachwaugh.com. All rights reserved.
//

#import "ClockWindow.h"

@implementation ClockWindow

- (instancetype)initWithContentRect:(NSRect)contentRect styleMask:(NSWindowStyleMask)style backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag
{	
	id result = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO];
	
	[result setBackgroundColor:[NSColor clearColor]];
	[result setLevel:NSStatusWindowLevel];
	[result setOpaque:NO];
	[result setHasShadow:NO];
	[result setMovableByWindowBackground:YES];
	
	return result;
}

- (void)cancelOperation:(id)sender
{
  [NSApp terminate:self];
}

- (BOOL)canBecomeKeyWindow
{
	return YES;
}

@end
