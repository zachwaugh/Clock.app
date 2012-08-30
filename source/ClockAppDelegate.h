//
//  AppController.h
//  Clock
//
//  Created by Zach Waugh on 2/15/08.
//  Copyright 2008 zachwaugh.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ClockView;
@class ClockWindow;

@interface ClockAppDelegate : NSObject <NSApplicationDelegate>

@property (weak) IBOutlet ClockView *view;
@property (weak) IBOutlet ClockWindow *window;
@property (weak) IBOutlet NSTextField *time;
@property (weak) IBOutlet NSTextField *date;
@property (strong) NSTimer *timer;

@end
