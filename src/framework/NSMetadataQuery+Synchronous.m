//
//  NSMetadataQuery+Synchronous.m
//
//  Created by Rob McBroom on 2012/03/22.
//

#import "NSMetadataQuery+Synchronous.h"

@implementation NSMetadataQuery (Synchronous)

- (NSArray *)resultsSync {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doneSearching:) name:NSMetadataQueryDidFinishGatheringNotification object:nil];
    
	if ([self startQuery]) {
		CFRunLoopRun();
		[[NSNotificationCenter defaultCenter] removeObserver:self name:NSMetadataQueryDidFinishGatheringNotification object:nil];
		return [self results];
	}
    
    else {
		[[NSNotificationCenter defaultCenter] removeObserver:self name:NSMetadataQueryDidFinishGatheringNotification object:nil];
		NSLog(@"Query failed to start: %@", self.predicate);
	}
	
    return nil;
}

- (void)doneSearching:(NSNotification *)note {
	[self stopQuery];
	CFRunLoopStop(CFRunLoopGetCurrent());
}

@end
