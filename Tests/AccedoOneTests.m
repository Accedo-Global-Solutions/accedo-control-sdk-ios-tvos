//
//  AccedoOneSDKFrameworkTests.m
//  AccedoOneSDKFrameworkTests
//
//  Created by Gabor Bottyan on 12/18/17.
//  Copyright © 2017 Gabor Bottyan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AccedoOne.h"
#import "AOCMSOptionalParams.h"

static NSString * kAOUUIDKey  = @"%@.UUID";
static const int kTCExpectationTimeout = 3000; //30 //seconds
@interface AppGridSDKFrameworkTests : XCTestCase
@property (nonatomic, retain) AccedoOne * appGridService;

@end

@implementation AppGridSDKFrameworkTests


- (void)setUp {
    if (!self.appGridService)
    {
        
    }
    
   
    
    NSString * apparidURL = @"https://appgrid-api.cloud.accedo.tv/";
    NSString * apparidKey = @"57563c029c9dad01e7b696c1";
    NSBundle * bundleId = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    NSString * uuid       = [NSString stringWithFormat:kAOUUIDKey, bundleId ? bundleId : @"tv.accedo.AppgridSDK" ];
    self.appGridService = [[AccedoOne alloc] initWithURL:apparidURL appKey:apparidKey userID:uuid];
    
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Metadata (fetching)

-(void) testAllMetadata
{
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"testAllMetadata"];
    
    [self.appGridService allMetadata:^(NSDictionary *allMetadata, AOError *err)
     {
         NSLog(@"appgrid allMetadata success: %@", allMetadata);
         
         [self.appGridService allMetadata:^(NSDictionary *allMetadata2, AOError *err) //test from cache (HTTP: 304)
          {
              if (err)
              {
                  XCTAssert(YES, @"Failed");
                  NSLog(@"appgrid allMetadata (cache) failure: %@", err);
              }
              else
              {
                  XCTAssert(YES, @"Success");
                  NSLog(@"appgrid allMetadata (cache) success: %@", allMetadata2);
              }
              
              [testExpectation fulfill];
          }];
     }];
    
    [self waitForExpectationsWithTimeout:kTCExpectationTimeout handler:nil];
}

-(void) testAllMetadataGUID
{
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"testAllMetadata"];
    
    NSString *gid = @"1234";
    
    [self.appGridService allMetadataForGID:gid onComplete:^(NSDictionary *allMetadata, AOError *err)
     {
         NSLog(@"appgrid allMetadata success: %@", allMetadata);
         
         [self.appGridService allMetadataForGID:gid onComplete:^(NSDictionary *allMetadata, AOError *err) //test from cache (HTTP: 304)
          {
              if (err)
              {
                  XCTAssert(YES, @"Failed");
                  NSLog(@"appgrid allMetadata (cache) failure: %@", err);
              }
              else
              {
                  XCTAssert(YES, @"Success");
                  NSLog(@"appgrid allMetadata (cache) success: %@", allMetadata);
              }
              
              [testExpectation fulfill];
          }];
     }];
    
    [self waitForExpectationsWithTimeout:kTCExpectationTimeout handler:nil];
}

/*
 -(void) testMetadata
 {
 XCTestExpectation *testExpectation = [self expectationWithDescription:@"testMetadata"];
 
 NSString * testKey = @"test_metadata";
 
 //test fetch resources...
 [self.appGridService metadataForKey:testKey onComplete:^(id metadata, AGRError *error)
 {
 if (error)
 {
 XCTAssert(NO, @"Failure");
 NSLog(@"testMetadata: %@", error);
 }
 else
 {
 XCTAssert(YES, @"Success");
 NSLog(@"testMetadata: %@", metadata);
 }
 
 [testExpectation fulfill];
 }];
 
 [self waitForExpectationsWithTimeout:kTCExpectationTimeout handler:nil];
 }
 */

/*
 -(void) testMetadataForKeyAndGID
 {
 XCTestExpectation *testExpectation = [self expectationWithDescription:@"testMetadata"];
 
 NSString * testKey = @"test_metadata";
 NSString * testGID = @"1234";
 
 //test fetch resources...
 [self.appGridService metadataForKey:testKey gid:testGID onComplete:^(id metadata, AGRError *error)
 {
 if (error)
 {
 XCTAssert(NO, @"Failure");
 NSLog(@"testMetadata: %@", error);
 }
 else
 {
 XCTAssert(YES, @"Success");
 NSLog(@"testMetadata: %@", metadata);
 }
 
 [testExpectation fulfill];
 }];
 
 [self waitForExpectationsWithTimeout:kTCExpectationTimeout handler:nil];
 }
 
 */

#pragma mark - Profile Information

-(void) testProfileInfo
{
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"testProfileInfo"];
    
    //test fetch resources...
    [self.appGridService profileInfo:^(NSDictionary *profileInfo, AOError *err)
     {
         NSLog(@"appgrid profileInfo success: %@", profileInfo);
         
         [self.appGridService profileInfo:^(NSDictionary *profileInfo, AOError *err) //test from cache (HTTP: 304)
          {
              if (err)
              {
                  XCTAssert(YES, @"Failed");
                  NSLog(@"appgrid profileInfo (cache) failure: %@", err);
              }
              else
              {
                  XCTAssert(YES, @"Success");
                  NSLog(@"appgrid profileInfo (cache) success: %@", profileInfo);
              }
              
              [testExpectation fulfill];
          }];
     }];
    
    [self waitForExpectationsWithTimeout:kTCExpectationTimeout handler:nil];
}

-(void) testProfileInfoForGID
{
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"testProfileInfo"];
    
    NSString * testGID = @"1234";
    
    //test fetch resources...
    [self.appGridService profileInfoForGID:testGID onComplete:^(NSDictionary *profileInfo, AOError *err)
     {
         NSLog(@"appgrid profileInfo success: %@", profileInfo);
         
         [self.appGridService profileInfoForGID:testGID onComplete:^(NSDictionary *profileInfo, AOError *err) //test from cache (HTTP: 304)
          {
              if (err)
              {
                  XCTAssert(YES, @"Failed");
                  NSLog(@"appgrid profileInfoForGID (cache) failure: %@", err);
              }
              else
              {
                  XCTAssert(YES, @"Success");
                  NSLog(@"appgrid profileInfoForGID (cache) success: %@", profileInfo);
              }
              
              [testExpectation fulfill];
          }];
     }];
    
    [self waitForExpectationsWithTimeout:kTCExpectationTimeout handler:nil];
}

#pragma mark - Metadata (Assets)

-(void) testAllAssets
{
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"testAllAssets"];
    
    //test fetch resources...
    [self.appGridService allAssets:^(NSDictionary *allAssets, AOError *err)
     {
         if (err)
         {
             XCTAssert(NO, @"Failed");
             NSLog(@"allAssets failure: %@", err);
         }
         else
         {
             XCTAssert(YES, @"Success");
             NSLog(@"allAssets: %@", allAssets);
         }
         
         [testExpectation fulfill];
     }];
    
    [self waitForExpectationsWithTimeout:kTCExpectationTimeout handler:nil];
}

#pragma mark - Metadata (Asset fetching: JSON)

- (void) testAsset
{
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"testAsset"];
    
    NSString *assetKey = @"asset_language_en";
    
    //test fetch JSON resource...
    [self.appGridService assetForKey:assetKey onComplete:^(NSData *resource, AOError *err)
     {
         if (err)
         {
             XCTAssert(NO, @"Failed");
             NSLog(@"appgrid assetWithKey failure: %@", err);
         }
         else
         {
             NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:resource options:NSJSONReadingMutableLeaves error:nil];
             
             if ([jsonObject isKindOfClass:[NSDictionary class]])
             {
                 XCTAssert(YES, @"Success");
                 NSLog(@"appgrid assetWithKey success!");
             }
             else
             {
                 XCTAssert(NO, @"Failed");
                 NSLog(@"appgrid assetWithKey failure: asset not JSON");
             }
         }
         
         [testExpectation fulfill];
     }];
    
    [self waitForExpectationsWithTimeout:kTCExpectationTimeout handler:nil];
}

#pragma mark - Metadata (Asset fetching: JSON)

-(void) testLanguageFile
{
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"testLanguageFile"];
    
    //test fetch language resource...
    [self.appGridService assetForKey:@"asset_language_en" onComplete:^(NSData *resource, AOError *err)
     {
         if (err)
         {
             XCTAssert(NO, @"Failed");
             NSLog(@"appgrid assetWithKey failure: %@", err);
         }
         else
         {
             NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:resource options:NSJSONReadingMutableContainers error:nil];
             
             XCTAssert(YES, @"Success");
             NSLog(@"appgrid assetWithKey success: %@", dict);
         }
         
         [testExpectation fulfill];
     }];
    
    [self waitForExpectationsWithTimeout:kTCExpectationTimeout handler:nil];
}

#pragma mark - Remote Logging

-(void) testRemoteLogging
{
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"testRemoteLogging"];
    
    [self.appGridService logWithLevel:AOServiceLogLevelError code:100 message:@"AppGridService: testRemoteLogging" dimensions:nil];
    
    XCTAssert(YES, @"Success");
    [testExpectation fulfill];
    
    [self waitForExpectationsWithTimeout:kTCExpectationTimeout handler:nil];
}

#pragma mark - User Data Storage

-(void) testStoreData
{
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"testStoreData"];
    
    NSString * userID = @"a1";
    NSDictionary * userData = @{@"name" : @"Name a1"};
    
    [self.appGridService storeData:userData forUser:userID scope:AOUserDataScopeApplication onComplete:^(AOError *err)
     {
         if (err)
         {
             XCTAssert(NO, @"Failed");
             NSLog(@"storeData failure: %@", err);
         }
         else
         {
             XCTAssert(YES, @"Success");
             NSLog(@"appgrid storeData success: %@", userData);
         }
         
         [testExpectation fulfill];
     }];
    
    [self waitForExpectationsWithTimeout:kTCExpectationTimeout handler:nil];
}

-(void) testGetAllDataForUser
{
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"testGetAllDataForUser"];
    
    NSString * userID = @"a1";
    
    [self.appGridService allDataForUser:userID scope:AOUserDataScopeApplication onComplete:^(NSDictionary *userData, AOError * err)
     {
         if (err)
         {
             XCTAssert(NO, @"Failed");
             NSLog(@"allDataForUser failure: %@", err);
         }
         else
         {
             XCTAssert(YES, @"Success");
             NSLog(@"appgrid allDataForUser success: %@", userData);
         }
         
         [testExpectation fulfill];
     }];
    
    [self waitForExpectationsWithTimeout:kTCExpectationTimeout handler:nil];
}

-(void) testStoreValue
{
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"testStoreValue"];
    
    NSString * userID    = @"a1";
    NSString * userValue = @"value A2";
    NSString * userKey   = @"keyA1 test";
    
    //store
    [self.appGridService storeValue:userValue key:userKey forUser:userID scope:AOUserDataScopeApplication onComplete:^(AOError * err) {
        if (err) {
            XCTAssert(NO, @"Failed");
            NSLog(@"storeValue failure: %@", err);
            
            [testExpectation fulfill];
        } else {
            //retrieve (check if store was correct)
            [self.appGridService dataForUser:userID key:userKey scope:AOUserDataScopeApplication onComplete:^(NSString *value, AOError *err) {
                if (err) {
                    XCTAssert(NO, @"Failed");
                    NSLog(@"storeValue failure: %@", err);
                } else {
                    if ([value isEqualToString:userValue]) {
                        XCTAssert(YES, @"Success");
                        NSLog(@"appgrid storeValue success: %@", userValue);
                    } else {
                        XCTAssert(NO, @"Failed");
                        NSLog(@"storeValue failure: no matching!");
                    }
                }
                
                [testExpectation fulfill];
            }];
        }
    }];
    
    [self waitForExpectationsWithTimeout:kTCExpectationTimeout handler:nil];
}

-(void) testGetDataForUser
{
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"testGetDataForUser"];
    
    NSString * userID  = @"a1";
    NSString * userKey = @"keyA1 test";
    
    [self.appGridService dataForUser:userID key:userKey scope:AOUserDataScopeApplication onComplete:^(NSString *value, AOError * err)
     {
         if (err)
         {
             XCTAssert(NO, @"Failed");
             NSLog(@"dataForUser failure: %@", err);
         }
         else
         {
             XCTAssert(YES, @"Success");
             NSLog(@"appgrid dataForUser success: %@", value);
         }
         
         [testExpectation fulfill];
     }];
    
    [self waitForExpectationsWithTimeout:kTCExpectationTimeout handler:nil];
}

-(void) testStoreValueScopeAppGroup
{
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"testStoreValueScopeAppGroup"];
    
    NSString * userID    = @"a1";
    NSString * userValue = @"value A2";
    NSString * userKey   = @"keyA1 test";
    
    //store
    [self.appGridService storeValue:userValue key:userKey forUser:userID scope:AOUserDataScopeApplicationGroup onComplete:^(AOError * err)
     {
         if (err)
         {
             XCTAssert(NO, @"Failed");
             NSLog(@"storeValue (group) failure: %@", err);
             
             [testExpectation fulfill];
         }
         else
         {
             //retrieve (check if store was correct)
             [self.appGridService dataForUser:userID key:userKey scope:AOUserDataScopeApplicationGroup onComplete:^(NSString *value, AOError *err)
              {
                  if (err)
                  {
                      XCTAssert(NO, @"Failed");
                      NSLog(@"storeValue (group) failure: %@", err);
                  }
                  else
                  {
                      if ([value isEqualToString:userValue])
                      {
                          XCTAssert(YES, @"Success");
                          NSLog(@"appgrid storeValue  (group) success: %@", userValue);
                      }
                      else
                      {
                          XCTAssert(NO, @"Failed");
                          NSLog(@"storeValue (group) failure: no matching!");
                      }
                  }
                  
                  [testExpectation fulfill];
              }];
         }
     }];
    
    [self waitForExpectationsWithTimeout:kTCExpectationTimeout handler:nil];
}

-(void) testGetDataForUserScopeAppGroup
{
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"testGetDataForUserScopeAppGroup"];
    
    NSString * userID  = @"a1";
    NSString * userKey = @"keyA1 test";
    
    //NSString * userID  = @"160205093710985";
    //NSString * userKey = @"lastWatchedMovies";
    //NSString * userKey = @"favoriteChannels";
    
    [self.appGridService dataForUser:userID key:userKey scope:AOUserDataScopeApplicationGroup onComplete:^(NSString *value, AOError * err)
     {
         if (err)
         {
             XCTAssert(NO, @"Failed");
             NSLog(@"dataForUser (group) failure: %@", err);
         }
         else
         {
             XCTAssert(YES, @"Success");
             NSLog(@"appgrid dataForUser (group) success: %@", value);
         }
         
         [testExpectation fulfill];
     }];
    
    [self waitForExpectationsWithTimeout:kTCExpectationTimeout handler:nil];
}

#pragma mark - CMS

-(void) testEntryForID
{
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"testEntryForID"];
    
    NSString * entryID  = @"5653ccfee4b00edd2262abdc";
    
    [self.appGridService entryForId:entryID onComplete:^(NSDictionary *entry, AOError *err)
     {
         if (err)
         {
             XCTAssert(NO, @"Failed");
             NSLog(@"testEntryForID failure: %@", err);
         }
         else
         {
             XCTAssert(YES, @"Success");
             NSLog(@"appgrid testEntryForID success: %@", entry);
         }
         
         [testExpectation fulfill];
     }];
    
    [self waitForExpectationsWithTimeout:kTCExpectationTimeout handler:nil];
}

-(void) testEntryForIDs
{
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"testEntryForIDs"];
    
    NSArray * entryIDs  = @[@"5653ccfee4b00edd2262abdc", @"5628aee3e4b0c8c257fc6a14"];
    
    [self.appGridService entriesForIds:entryIDs onComplete:^(NSArray *entries, AOError *err)
     {
         if (err)
         {
             XCTAssert(NO, @"Failed");
             NSLog(@"testEntryForIDs failure: %@", err);
         }
         else
         {
             XCTAssert(YES, @"Success");
             NSLog(@"appgrid testEntryForIDs success: %@", entries);
         }
         
         [testExpectation fulfill];
     }];
    
    [self waitForExpectationsWithTimeout:kTCExpectationTimeout handler:nil];
}

-(void) testEntryForAliases
{
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"testEntryForAliases"];
    
    NSArray * aliases  = @[@"home", @"tvshows", @"container"];
    
    [self.appGridService entriesForAliases:aliases onComplete:^(NSArray * _Nonnull entries, AOError * _Nonnull err)
     {
         if (err)
         {
             XCTAssert(NO, @"Failed");
             NSLog(@"testEntryForAliases failure: %@", err);
         }
         else
         {
             XCTAssert(YES, @"Success");
             NSLog(@"appgrid testEntryForAliases success: %@", entries);
         }
         
         [testExpectation fulfill];
     }];
    
    [self waitForExpectationsWithTimeout:kTCExpectationTimeout handler:nil];
}

-(void) testEntryForTypeAlias
{
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"testEntryForTypeAliases"];
    
    NSString * alias = @"container";
    
    AOCMSOptionalParams * params = [[AOCMSOptionalParams params] paramWithPreview:NO];
    [params paramWithPageSize:@(2)];
    
    [self.appGridService entriesForTypeAlias:alias optionalParams:params onComplete:^(NSArray * _Nonnull entries, AOError * _Nonnull err)
     {
         if (err)
         {
             XCTAssert(NO, @"Failed");
             NSLog(@"testEntryForTypeAliases failure: %@", err);
         }
         else
         {
             XCTAssert(YES, @"Success");
             NSLog(@"appgrid testEntryForTypeAliases success: %@", entries);
         }
         
         [testExpectation fulfill];
     }];
    
    [self waitForExpectationsWithTimeout:kTCExpectationTimeout handler:nil];
}

-(void) testEntryForType
{
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"testEntryForType"];
    
    NSString * type = @"5628aed8e4b0c8c257fc6a0f";
    
    AOCMSOptionalParams * params = nil ;//[[CMSOptionalParams params] paramWithDateAt:[NSDate date]];
    
    [self.appGridService entriesForType:type optionalParams:params onComplete:^(AOPageResult *result, AOError *err)
     {
         if (err)
         {
             XCTAssert(NO, @"Failed");
             NSLog(@"testEntryForType failure: %@", err);
         }
         else
         {
             XCTAssert(YES, @"Success");
             NSLog(@"appgrid testEntryForType success: %@", result.content);
         }
         
         [testExpectation fulfill];
     }];
    
    [self waitForExpectationsWithTimeout:kTCExpectationTimeout handler:nil];
}

-(void) testAllEntries
{
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"testAllEntries"];
    
    [self.appGridService allEntries:^(AOPageResult *result, AOError *err)
     {
         if (err)
         {
             XCTAssert(NO, @"Failed");
             NSLog(@"allEntries failure: %@", err);
         }
         else
         {
             XCTAssert(YES, @"Success");
             NSLog(@"appgrid allEntries success: %@", result.content);
         }
         
         [testExpectation fulfill];
     }];
    
    [self waitForExpectationsWithTimeout:kTCExpectationTimeout handler:nil];
}

-(void) testLocales
{
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"testLocales"];
    
    [self.appGridService localesOnComplete:^(NSArray * _Nullable locales, AOError * _Nullable err)
     {
         if (err)
         {
             XCTAssert(NO, @"Failed");
             NSLog(@"localesOnComplete failure: %@", err);
         }
         else
         {
             XCTAssert(YES, @"Success");
             NSLog(@"appgrid localesOnComplete success: %@", locales);
         }
         
         [testExpectation fulfill];
     }];
    
    [self waitForExpectationsWithTimeout:kTCExpectationTimeout handler:nil];
}

-(void) testAllEntriesWithLocale
{
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"testAllEntries"];
    
    AOCMSOptionalParams *param = [[AOCMSOptionalParams params] paramWithLocale:@"en"];
    
    [self.appGridService allEntriesForParams:param onComplete:^(AOPageResult * _Nonnull result, AOError * _Nonnull err) {
        if (err)
        {
            XCTAssert(NO, @"Failed");
            NSLog(@"allEntries failure: %@", err);
        }
        else
        {
            XCTAssert(YES, @"Success");
            NSLog(@"appgrid allEntries success: %@", result.content);
        }
        
        [testExpectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:kTCExpectationTimeout handler:nil];
}


@end
