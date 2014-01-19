//
//  NSError+True.m
//  TrueIMPRESSIONS
//
//  Created by Victor Shcherbakov on 01/09/13.
//  Copyright (c) 2013 Victor Shcherbakov. All rights reserved.
//

#import "NSError+True.h"

@implementation NSError (True)

+(NSError*)trueErrorWithServerResponseString:(NSString*)serverResponseString{
    if ([serverResponseString hasPrefix:@"ERROR"]) {
        NSArray* responseArray = [serverResponseString componentsSeparatedByString:@"\n"];
        NSError* error = [NSError errorWithDomain:@"LMTRUEIMPRESSIONSSERVER"
                                             code:732001
                                         userInfo:@{NSLocalizedDescriptionKey : responseArray[1] ? responseArray[1] : @"Неизвестная ошибка на сервере!"}];
        return error;
    }else{
        return nil;
    }
}

@end
