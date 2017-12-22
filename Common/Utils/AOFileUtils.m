//
//  AOFileUtils.m
//  AccedoOne
//
//  Copyright (c) 2017 - present Accedo Broadband AB. All Rights Reserved
//  Unauthorized copying of this file, via any medium is strictly prohibited
//  Proprietary and confidential
//
#import "AOFileUtils.h"

@implementation AOFileUtils

+ (NSString *) applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
    if (basePath)
    {
        NSURL * baseURL = [NSURL fileURLWithPath:basePath];
        
        [AOFileUtils addSkipBackupAttributeToItemAtURL:baseURL];
    }
    
    return basePath;
}

+ (BOOL) addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    NSError *error = nil;
    
    BOOL success = [URL setResourceValue:[NSNumber numberWithBool: YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
    
    if(!success)
    {
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    
    return success;
}

+ (NSString *) pathToFileInDocumentsDirectoryWithName: (NSString *) fileName
{
    return [AOFileUtils pathToFileInDocumentsDirectoryWithName: fileName inFolder: nil];
}

+ (NSString *) pathToFileInDocumentsDirectoryWithName: (NSString *) fileName inFolder: (NSString*) folder
{
    NSString *documentsPath = [AOFileUtils applicationDocumentsDirectory];
    
    if (folder)
    {
        documentsPath = [documentsPath stringByAppendingFormat:@"/%@/", folder];
    }
    
    NSString *returnValue = nil;
    
    if (documentsPath)
    {
        returnValue = [documentsPath stringByAppendingPathComponent: fileName];
    }
    
    return returnValue;
}

+ (NSString *) pathToFolderInDocumentsDirectoryWithName: (NSString *) folderName
{
    NSString *documentsPath = [AOFileUtils applicationDocumentsDirectory];
    
    return  [documentsPath stringByAppendingFormat:@"/%@", folderName];
}


@end
