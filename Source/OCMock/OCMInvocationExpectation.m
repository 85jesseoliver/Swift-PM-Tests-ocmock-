/*
 *  Copyright (c) 2014-2020 Erik Doernenburg and contributors
 *
 *  Licensed under the Apache License, Version 2.0 (the "License"); you may
 *  not use these files except in compliance with the License. You may obtain
 *  a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 *  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 *  License for the specific language governing permissions and limitations
 *  under the License.
 */

#import "OCMInvocationExpectation.h"
#import "NSInvocation+OCMAdditions.h"


@implementation OCMInvocationExpectation

- (void)setMatchAndReject:(BOOL)flag
{
    matchAndReject = flag;
    if(matchAndReject)
    {
        isSatisfied = YES;
        if([invocationActions count] > 0)
        {
            [NSException raise:NSInternalInconsistencyException format:@"%@: reject expectations can't have actions attached to them: %@",
                [self description], invocationActions];
        }
    }
}

- (BOOL)isMatchAndReject
{
  return matchAndReject;
}

- (BOOL)isSatisfied
{
    return isSatisfied;
}

- (void)handleInvocation:(NSInvocation *)anInvocation
{
    if(matchAndReject)
    {
        isSatisfied = NO;
        [NSException raise:NSInternalInconsistencyException format:@"%@: explicitly disallowed method invoked: %@",
                [self description], [anInvocation invocationDescription]];
    }
    else
    {
        [super handleInvocation:anInvocation];
        isSatisfied = YES;
    }
}

- (void)addInvocationAction:(id)anAction {
    if(matchAndReject)
    {
        [NSException raise:NSInternalInconsistencyException format:@"%@: reject expectations can't have actions attached to them: %@",
            [self description], anAction];
    }
    [super addInvocationAction:anAction];
}

@end
