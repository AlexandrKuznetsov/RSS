//
//  TIMModelWithStaticData.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 19.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TIMModelWithStaticData : NSObject

- (NSMutableDictionary*)getCounryDictWithCountryName:(NSString*)name;
- (NSArray*)countryList;
- (NSArray *)privacyArray;
- (NSArray *)languageArray;
- (NSArray *)genderArray;
- (NSDictionary*)formatInterestsDictionaryFromString:(NSString*)interests;
- (NSString *)formatInterestsString:(NSInteger)count;

@end
