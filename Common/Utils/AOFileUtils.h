//
//  AOFileUtils.h
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//
#import <Foundation/Foundation.h>

@interface AOFileUtils : NSObject

+(NSString *) applicationDocumentsDirectory;

+(NSString *) pathToFileInDocumentsDirectoryWithName: (NSString *) fileName;

+(NSString *) pathToFileInDocumentsDirectoryWithName: (NSString *) fileName inFolder: (NSString*) folder;

+(NSString *) pathToFolderInDocumentsDirectoryWithName: (NSString *) folderName;


@end
