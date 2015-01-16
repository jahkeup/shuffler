//
//  AppDelegate.h
//  Shuffler
//
//  Created by Jacob Vallejo on 1/16/15.
//  Copyright (c) 2015 Jahkeup.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
@property (weak) IBOutlet NSTextField *sourceDirectoryField;
@property (weak) IBOutlet NSTextField *destDirectoryField;
@property (strong) NSURL* sourceDirectory;
@property (strong) NSURL* destinationDirectory;

- (IBAction)shuffleButton:(id)sender;
- (IBAction)destSelect:(id)sender;
- (IBAction)sourceSelect:(id)sender;


@end

