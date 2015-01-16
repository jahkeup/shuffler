//
//  FileShuffle.m
//  Shuffler
//
//  Created by Jacob Vallejo on 1/16/15.
//  Copyright (c) 2015 Jahkeup.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "FileShuffle.h"

@implementation FileShuffle : NSObject 

- (Boolean)isDirectory:(NSString *)path {
    BOOL yup;
    return [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&yup] && yup;
}

- (Boolean)shuffleDirectory:(NSURL*)directory destination:(NSURL*)dest prefix:(NSString*)prefix {
    NSFileManager* fm = [NSFileManager defaultManager];
    NSLog(@"Shuffling directory '%@' into '%@' with prefix '%@'.", directory, dest, prefix);
    NSArray *files = [fm contentsOfDirectoryAtPath:[directory path] error:NULL];
    // There were no files to be shuffled
    NSLog(@"Shuffler found %ld files to be shuffled", (long)[files count]);
    BOOL __block successful = YES;
    if ([files count] == 0) return false;
    if (![self isDirectory:[dest path]]) {
        if ([fm createDirectoryAtPath:[dest path] withIntermediateDirectories:YES attributes:nil error:nil]) {
            NSLog(@"Shuffler creating destination directory '%@'", [dest path]);
        } else {
            successful = false;
            return successful;
        }
    }

    [files enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        NSString* filename = (NSString*)obj;
        
        if (![filename isEqual: @".DS_Store"] || [self isDirectory:filename]) {
            NSString* guid =  [[[NSUUID UUID] UUIDString] substringToIndex:6];
            NSString* destFilename = [NSString stringWithFormat:@"%@_%@_%@", prefix, guid, filename];
            NSLog(@"Generated filename: %@", destFilename);
            NSString* sourcePath = [NSString pathWithComponents:[NSArray arrayWithObjects:[directory path],filename, nil]];
            NSString* destinationPath = [NSString pathWithComponents:[NSArray arrayWithObjects:[dest path], destFilename, nil]];
            
            NSLog(@"Shuffling file from '%@' to '%@'.", sourcePath, destinationPath);
            if (![fm copyItemAtPath:sourcePath toPath:destinationPath error:nil]) {
                *stop = YES;
                successful = NO;
            }
        }
        
    }];
    
    return successful;
}

@end