//
//  FileShuffle.h
//  Shuffler
//
//  Created by Jacob Vallejo on 1/16/15.
//  Copyright (c) 2015 Jahkeup.com. All rights reserved.
//

@interface FileShuffle : NSObject
- (Boolean)isDirectory:(NSString *)path;
- (Boolean)shuffleDirectory:(NSURL*)directory destination:(NSURL*)dest prefix:(NSString*)prefix;
@end