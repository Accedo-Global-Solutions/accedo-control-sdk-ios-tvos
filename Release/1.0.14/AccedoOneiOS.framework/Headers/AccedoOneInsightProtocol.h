//
//  AccedoOneInsightProtocol.h
//  AccedoOne
//
//  Copyright (c) 2018 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

@protocol AccedoOneInsightProtocol <NSObject>

- (void) applicationStart;
- (void) applicationStartSuccess:(nullable AOSuccessBlock)completionBlock onFailure:(nullable AOErrorBlock)failureBlock;

- (void) applicationStop;
- (void) applicationStop:(BOOL)clearCache;

@end
