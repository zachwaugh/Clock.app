//
//  ClockView.m
//  Clock
//
//  Created by Zach Waugh on 2/15/08.
//  Copyright 2008 zachwaugh.com. All rights reserved.
//

#import "ClockView.h"

@implementation ClockView

@synthesize textRect, textSize, backgroundColor, clipShape, textAttributes, dateAttributes;


- (id)initWithFrame:(NSRect)frame 
{
	if (self = [super initWithFrame:frame])
	{
		self.backgroundColor = [NSColor colorWithCalibratedWhite:0 alpha:0.35];
		
		// Configure current time
		NSString *clockDisplay = [[NSDate date] descriptionWithCalendarFormat:@"%I:%M:%S %p" timeZone:nil locale:nil];
		
		// Create attributes dict for time text formatting
		self.textAttributes = [[NSMutableDictionary alloc] init];
		[self.textAttributes setObject:[NSFont fontWithName:@"Helvetica" size:215.0] forKey:NSFontAttributeName];
		[self.textAttributes setObject:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
		
		// Create attributes dict for date text formatting
		self.dateAttributes = [[NSMutableDictionary alloc] init];
		[self.dateAttributes setObject:[NSFont fontWithName:@"HelveticaNeue-Light" size:72.0] forKey:NSFontAttributeName];
		[self.dateAttributes setObject:[NSColor colorWithCalibratedWhite:1.0 alpha:0.5] forKey:NSForegroundColorAttributeName];
		NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
		[style setAlignment:NSCenterTextAlignment];
		[self.dateAttributes setObject:style forKey:NSParagraphStyleAttributeName];

		NSShadow *shadow = [[NSShadow alloc] init];
		[shadow setShadowColor:self.backgroundColor];
		[shadow setShadowBlurRadius:10.0];
		[self.textAttributes setObject:shadow forKey:NSShadowAttributeName];
		
		// Calculate size of displayed text on screen
		NSSize displaySize = [clockDisplay sizeWithAttributes:self.textAttributes];
		displaySize.width += 100.0;
		displaySize.height += 50.0;
		
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
	
	// calculate rect for time and date
	NSRect timeRect = self.textRect;
	timeRect.origin.y -= 10;

	NSRect dateRect = self.textRect;
	dateRect.origin.x = 0;
	dateRect.origin.y += 210;
	
	NSDate *now = [NSDate date];
	[[now descriptionWithCalendarFormat:@"%I:%M:%S %p" timeZone:nil locale:nil] drawInRect:timeRect withAttributes:self.textAttributes];
	[[now descriptionWithCalendarFormat:@"%x" timeZone:nil locale:nil] drawInRect:dateRect withAttributes:self.dateAttributes];
}

@end
