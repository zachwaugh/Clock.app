//
//  AppController.m
//  Clock
//
//  Created by Zach Waugh on 2/15/08.
//  Copyright 2008 zachwaugh.com. All rights reserved.
//

#import "ClockAppDelegate.h"
#import "ClockView.h"
#import "ClockWindow.h"

#define TICK_INTERVAL 0.5 // Update clock twice a second, should be enough


// Private methods
@interface ClockAppDelegate ()

@property (strong) NSDateFormatter *timeFormatter;
@property (strong) NSDictionary *timeAttributes;

- (void)tick:(NSTimer *)aTimer;
- (void)startClock;
- (void)stopClock;
- (void)updateTime;

@end

@implementation ClockAppDelegate

- (void)awakeFromNib
{
  NSShadow *shadow = [[NSShadow alloc] init];
  [shadow setShadowColor:[NSColor colorWithCalibratedWhite:0 alpha:0.25]];
  [shadow setShadowBlurRadius:8];
  
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  [paragraphStyle setAlignment:NSCenterTextAlignment];
  
  // Cache the time formatter and attributes since we use these twice a second
  self.timeAttributes = @{NSForegroundColorAttributeName : [NSColor whiteColor], NSFontAttributeName : [NSFont fontWithName:@"HelveticaNeue" size:192], NSShadowAttributeName : shadow, NSParagraphStyleAttributeName : paragraphStyle};
  self.timeFormatter = [[NSDateFormatter alloc] init];
  [self.timeFormatter setTimeStyle:NSDateFormatterMediumStyle];
  [self.timeFormatter setDateStyle:NSDateFormatterNoStyle];
  
  // Only set the date once at launch, so don't bother storing formatter/attributes
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
  [dateFormatter setDateStyle:NSDateFormatterLongStyle];
  NSDictionary *dateAttributes = @{NSForegroundColorAttributeName : [NSColor colorWithCalibratedWhite:1.0 alpha:0.5], NSFontAttributeName : [NSFont fontWithName:@"HelveticaNeue-Bold" size:72], NSShadowAttributeName : shadow,NSParagraphStyleAttributeName : paragraphStyle};
  
  NSDate *now = [NSDate date];
  [self.time setAttributedStringValue:[[NSAttributedString alloc] initWithString:[self.timeFormatter stringFromDate:now] attributes:self.timeAttributes]];
  [self.date setAttributedStringValue:[[NSAttributedString alloc] initWithString:[dateFormatter stringFromDate:now] attributes:dateAttributes]];
  [self startClock];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
	[self stopClock];
}

- (void)tick:(NSTimer *)aTimer
{
  [self updateTime];
}

- (void)updateTime
{
  [self.time setAttributedStringValue:[[NSAttributedString alloc] initWithString:[self.timeFormatter stringFromDate:[NSDate date]] attributes:self.timeAttributes]];
}

- (void)startClock
{
	self.timer = [NSTimer timerWithTimeInterval:TICK_INTERVAL target:self selector:@selector(tick:) userInfo:nil repeats:YES];
  [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopClock
{
	[self.timer invalidate];
  self.timer = nil;
}

@end
