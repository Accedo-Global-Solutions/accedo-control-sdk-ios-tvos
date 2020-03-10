//
//  AccedoOneCacheProtocol.h
//  AccedoOne
//
//  Copyright (c) 2018 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//

@class AOCacheHandler;

@protocol AccedoOneCacheProtocol <NSObject>

- (void) addDictionary:(NSDictionary *_Nonnull) dictionary toOfflineAccedoOneConfigWithKey:(NSString *_Nonnull) key;
- (NSDictionary *_Nullable) dictionaryFromOfflineAccedoOneProfileWithKey:(NSString *_Nonnull) key;
- (NSDictionary *_Nullable) dictionaryFromOfflineAccedoOneConfigWithKey:(NSString *_Nonnull) key;
- (NSString *_Nullable) ifModifiedSinceDateForCachedObject:(NSString *_Nonnull)cacheKey cache:(id<AOCacheHandler> _Nonnull) cache;

@end
