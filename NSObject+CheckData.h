//
//  NSString+CheckData.h
//  TrueIMPRESSION
//
//  Created by fist on 1/12/14.
//  Copyright (c) 2014 Impression. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface NSObject (CheckData)

- (NSString*)checkFirsStepRegistration:(NSString*)mail
                             pass:(NSString*)pass
                   andConfirmPass:(NSString*)confirmPass;

@end
