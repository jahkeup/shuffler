//
//  AppDelegate.m
//  Shuffler
//
//  Created by Jacob Vallejo on 1/16/15.
//  Copyright (c) 2015 Jahkeup.com. All rights reserved.
//

#import "AppDelegate.h"
#import "FileShuffle.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end


@implementation AppDelegate
@synthesize sourceDirectoryField;
@synthesize destDirectoryField;

@synthesize sourceDirectory;
@synthesize destinationDirectory;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    NSLog(@"Started shuffler");
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)app {
    return YES;
}

- (IBAction)shuffleButton:(id)sender {
    
    FileShuffle* shuffler = [[FileShuffle alloc] init];
    NSAlert* alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"Okay"];
    [alert setMessageText:@"Shuffler"];

    if (sourceDirectory == NULL || destinationDirectory == NULL) {
        [alert setInformativeText:@"You must define both source and destination directories"];
        [alert runModal];
        return;
    }
    NSLog(@"Running shuffler..");
    if ([shuffler shuffleDirectory:sourceDirectory
                       destination:destinationDirectory
                            prefix:@"shuffled" ]) {
        [alert setInformativeText:@"Shuffle completed successfully."];
        [alert runModal];
        [[NSWorkspace sharedWorkspace] selectFile:NULL inFileViewerRootedAtPath:[destinationDirectory path]];
        // Close on finish
        [[NSApplication sharedApplication] terminate:nil];
    } else {
        [alert setInformativeText:@"Shuffle did not complete, an error occurred."];
        [alert runModal];
    }

}

- (IBAction)sourceSelect:(id)sender {
    sourceDirectory = [self selectDirectory:sourceDirectoryField];
    if (destinationDirectory == NULL) {
        destinationDirectory = [sourceDirectory URLByAppendingPathComponent:@"shuffled"];
        [destDirectoryField setStringValue:[destinationDirectory path]];
    }
        
}

- (IBAction)destSelect:(id)sender {
    destinationDirectory = [self selectDirectory:destDirectoryField];
}

- (NSURL*)selectDirectory:(NSTextField*)fieldSetString {
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    [openDlg setCanChooseDirectories:true];
    [openDlg setCanChooseFiles:false];
    [openDlg setCanCreateDirectories:true];
    if ([openDlg runModal] == NSOKButton) {
        NSURL *path = [openDlg URL];
        NSLog(@"Selected path: %@", [path path]);
        [fieldSetString setStringValue:[path path]];
        return path;
    }
    return NULL;
}

@end
