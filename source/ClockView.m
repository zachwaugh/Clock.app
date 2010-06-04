//
//  ClockView.m
//  Clock
//
//  Created by Zach Waugh on 2/15/08.
//  Copyright 2008 zachwaugh.com. All rights reserved.
//

#import "ClockView.h"

@implementation ClockView

@synthesize textRect, textSize, backgroundColor, clipShape, textAttributes;


- (id)initWithFrame:(NSRect)frame 
{
	if (self = [super initWithFrame:frame])
	{
		self.backgroundColor = [NSColor colorWithCalibratedWhite:0 alpha:0.35];
		
		// Configure current time
		NSString *clockDisplay = [[NSDate date] descriptionWithCalendarFormat:@"%I:%M:%S %p" timeZone:nil locale:nil];
		
		// Create attributes dict for text formatting
		self.textAttributes = [[NSMutableDictionary alloc] init];
		[self.textAttributes setObject:[NSFont fontWithName:@"Helvetica" size:225.0] forKey:NSFontAttributeName];
		[self.textAttributes setObject:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
		
		NSShadow *shadow = [[NSShadow alloc] init];
		[shadow setShadowColor:self.backgroundColor];
		[shadow setShadowBlurRadius:10.0];
		[self.textAttributes setObject:shadow forKey:NSShadowAttributeName];
		
		// Calculate size of displayed text on screen
		NSSize displaySize = [clockDisplay sizeWithAttributes:self.textAttributes];
		displaySize.width += 100.0;
		
		// Give some space on sides of text
		self.textSize = displaySize;
		
		// Create rounded rectangle
		self.clipShape = [[NSBezierPath alloc] init];
		
		// Specify clipshape dimensions now that we have calculated the size of the text display
		[self.clipShape appendBezierPathWithRoundedRect:NSMakeRect(0.0, 0.0, self.textSize.width, self.textSize.height) xRadius:25.0 yRadius:25.0];
		
		self.textRect = NSMakeRect(50.0, 0.0, self.textSize.width, self.textSize.height);
	}
	
	return self;
}


- (void)awakeFromNib
{
	NSSize screenSize = [[NSScreen mainScreen] frame].size;
	NSRect windowRect = NSMakeRect((screenSize.width - self.textSize.width) / 2, (screenSize.height - self.textSize.height) / 2, self.textSize.width, self.textSize.height);
	[[self window] setFrame:windowRect display:YES];
}


// Allow for transparency
- (BOOL)isOpaque
{
	return NO;
}


- (BOOL)isFlipped
{
	return YES;
}


- (void)drawRect:(NSRect)rect 
{
	// Clear existing display
	[[NSColor clearColor] set];
	NSRectFill(self.bounds);
	
	// Set color to semi-transparent black and fill clip shape
	[self.backgroundColor set];
	[self.clipShape fill];
	
	[[[NSDate date] descriptionWithCalendarFormat:@"%I:%M:%S %p" timeZone:nil locale:nil] drawInRect:self.textRect withAttributes:self.textAttributes];
}

@end
