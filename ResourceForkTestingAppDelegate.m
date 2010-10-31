//
//  ResourceForkTestingAppDelegate.m
//  ResourceForkTesting
//
//  Created by Alex Nichol on 10/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ResourceForkTestingAppDelegate.h"
#import "ResourceForkManager.h"


@implementation ResourceForkTestingAppDelegate

@synthesize window;

- (void)awakeFromNib {
	[dragView setDelegate:self];
}

- (NSData *)dataFromString:(NSString *)string {
	return [string dataUsingEncoding:NSUTF8StringEncoding];
}

- (void)fileNameChanged:(id)sender {
	// here we load the fork
	NSString * fileName = [dragView fileName];
	ResourceForkManager * man = [[ResourceForkManager alloc] init];
	[man openResourceForFile:fileName];
	[resourceForkText setStringValue:[man readStringFromFile]];
	[man closeFile];
	[man release];
}

- (IBAction)saveFork:(id)sender {
	// here we save the fork
	NSData * data = [self dataFromString:[resourceForkText stringValue]];
	NSString * filename = [dragView fileName];
	ResourceForkManager * man = [[ResourceForkManager alloc] init];
	[man openResourceForFile:filename];
	[man writeDataToFile:data];
	[man closeFile];
	[man release];
	
}



@end
