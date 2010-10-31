//
//  ResourceForkTestingAppDelegate.h
//  ResourceForkTesting
//
//  Created by Alex Nichol on 10/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DragView.h"

@interface ResourceForkTestingAppDelegate : NSObject <DragViewDelegate> {
    NSWindow * window;
	IBOutlet DragView * dragView;
	IBOutlet NSTextField * resourceForkText;
}

- (IBAction)saveFork:(id)sender;
@property (assign) IBOutlet NSWindow *window;

@end
