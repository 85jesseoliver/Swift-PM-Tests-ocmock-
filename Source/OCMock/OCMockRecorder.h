//---------------------------------------------------------------------------------------
//  $Id$
//  Copyright (c) 2004-2013 by Mulle Kybernetik. See License file for details.
//---------------------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@interface OCMockRecorder : NSProxy 
{
	id				signatureResolver;
    BOOL            recordingClassMethod;
	NSInvocation	*recordedInvocation;
	NSMutableArray	*invocationHandlers;
}

- (id)initWithSignatureResolver:(id)anObject;

- (BOOL)matchesSelector:(SEL)sel;
- (BOOL)matchesInvocation:(NSInvocation *)anInvocation;
- (void)releaseInvocation;

- (id)andReturn:(id)anObject;
- (id)andReturnValue:(NSValue *)aValue;
- (id)andThrow:(NSException *)anException;
- (id)andPost:(NSNotification *)aNotification;
- (id)andCall:(SEL)selector onObject:(id)anObject;
#if NS_BLOCKS_AVAILABLE
- (id)andDo:(void (^)(NSInvocation *))block; 
#endif
- (id)andForwardToRealObject;

- (id)classMethod;

- (NSArray *)invocationHandlers;

@end
