//
//  NSError+True.h
//  TrueIMPRESSIONS
//
//  Created by Victor Shcherbakov on 01/09/13.
//  Copyright (c) 2013 Victor Shcherbakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (True)

+(NSError*)trueErrorWithServerResponseString:(NSString*)serverResponseString;

@end
