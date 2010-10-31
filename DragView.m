//
//  DragView.m
//  SudoTerminal
//
//  Created by Alex Nichol on 11/13/09.
//  Copyright 2009 Jitsik. All rights reserved.
//

#import "DragView.h"


@implementation DragView

@synthesize delegate;

- (NSString *)fileName {
	return fileName;
}

- (void)setFileName:(NSString *)_fileName {
	[fileName release];
	fileName = [_fileName retain];
	[self updateImage];
	[delegate fileNameChanged:self];
}

- (void)setImage:(NSImage *)_image {
	[img release];
	img = [_image retain];
	[self setNeedsDisplay:YES];
}

- (NSImage *)image {
	return img;
}

- (void)updateImage {
	[self setImage:[[NSWorkspace sharedWorkspace] iconForFile:fileName]];
}

- (void)awakeFromNib {
	// view did load
	backName = [NSImage imageNamed:@"drackback.png"];
	[self registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
	[self setNeedsDisplay:YES];
	//iv = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, [self frame].size.width, [self frame].size.height)];
	//[iv setImageFrameStyle:NSImageFrameGrayBezel];
	//[self addSubview:iv];
}

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
	[backName drawInRect:NSMakeRect(0, 0, 256, 256) fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0f];
	// done
	
	float imageWidth = [img size].width;
	float imageHeight = [img size].height;
	if (imageWidth > imageHeight) {
		float divx = (imageWidth / [self frame].size.width);
		imageWidth /= divx;
		imageHeight /= divx;
	} else {
		float divx = (imageHeight / [self frame].size.width);
		imageWidth /= divx;
		imageHeight /= divx;
	}
	
	imageWidth /= 2;
	imageHeight /= 2;
	
	NSRect newRect = NSMakeRect(([self frame].size.width / 2) - (imageWidth / 2), ([self frame].size.height / 2) - (imageHeight / 2), imageWidth, imageHeight);
		
	[img drawInRect:newRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0f];
}

- (void)dealloc {
	[self unregisterDraggedTypes];
	[super dealloc];
}

#pragma mark Drag and Drop

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask]) 
		== NSDragOperationGeneric) {
        //this means that the sender is offering the type of operation we want
        //return that we want the NSDragOperationGeneric operation that they 
		//are offering
        return NSDragOperationGeneric;
    } else {
        //since they aren't offering the type of operation we want, we have 
		//to tell them we aren't interested
        return NSDragOperationNone;
    }
}

- (void)draggingExited:(id<NSDraggingInfo>)sender {
    //we aren't particularily interested in this so we will do nothing
    //this is one of the methods that we do not have to implement
}

- (NSDragOperation)draggingUpdated:(id<NSDraggingInfo>)sender {
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask]) 
		== NSDragOperationGeneric) {
        //this means that the sender is offering the type of operation we want
        //return that we want the NSDragOperationGeneric operation that they 
		//are offering
        return NSDragOperationGeneric;
    } else {
        //since they aren't offering the type of operation we want, we have 
		//to tell them we aren't interested
        return NSDragOperationNone;
    }
}

- (void)draggingEnded:(id<NSDraggingInfo>)sender {
    //we don't do anything in our implementation
    //this could be ommitted since NSDraggingDestination is an infomal
	//protocol and returns nothing
}

- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender {
    return YES;
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender {
    NSPasteboard * paste = [sender draggingPasteboard];
	//gets the dragging-specific pasteboard from the sender
    NSArray * types = [NSArray arrayWithObjects:NSTIFFPboardType, 
					  NSFilenamesPboardType, nil];
	//a list of types that we can accept
    NSString * desiredType = [paste availableTypeFromArray:types];
    NSData * carriedData = [paste dataForType:desiredType];
	
    if (nil == carriedData) {
        //the operation failed for some reason
        NSRunAlertPanel(@"Paste Error", @"Sorry, but the past operation failed", 
						nil, nil, nil);
        return NO;
    } else {
        // the pasteboard was able to give us some meaningful data
        if ([desiredType isEqualToString:NSFilenamesPboardType]) {
            NSArray * fileArray = [paste propertyListForType:@"NSFilenamesPboardType"];
            NSString * path = [fileArray objectAtIndex:0];
            //read path
			[self setFileName:path];
        } else {
            // this can't happen
            NSRunAlertPanel(@"Not a file", @"Please drag in a file.", @"OK", nil, nil);
            return NO;
        }
    }
    return YES;
}

- (void)concludeDragOperation:(id<NSDraggingInfo>)sender {
    //re-draw the view with our new data
    [self setNeedsDisplay:YES];
}

@end
