/*
 *  Copyright (c) 2014 Erik Doernenburg and contributors
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
}

- (BOOL)isSatisfied
{
    return isSatisfied;
}

- (BOOL)handleInvocation:(NSInvocation *)anInvocation
{
    BOOL result = [super handleInvocation:anInvocation];
    if(result)
    {
        isSatisfied = YES;
        if(matchAndReject)
        {
            NSString *reason = [NSString stringWithFormat:@"%@: explicitly disallowed method invoked: %@",
                                   [self description], [anInvocation invocationDescription]];
            [[NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:nil] raise];
        }
    }
    return result;
}

@end