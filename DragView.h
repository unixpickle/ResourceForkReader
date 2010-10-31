//
//  DragView.h
//  SudoTerminal
//
//  Created by Alex Nichol on 11/13/09.
//  Copyright 2009 Jitsik. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol DragViewDelegate

- (void)fileNameChanged:(id)sender;

@end


@interface DragView : NSView {
	NSImage * img;
	NSString * fileName;
	NSImage * backName;
	id<DragViewDelegate> delegate;
}
@property (nonatomic, assign) id<DragViewDelegate> delegate;
- (NSString *)fileName;
- (void)setFileName:(NSString *)_fileName;
- (void)setImage:(NSImage *)_image;
- (NSImage *)image;
- (void)updateImage;
@end
