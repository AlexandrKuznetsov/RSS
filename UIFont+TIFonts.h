//
//  UIFont+TIFonts.h
//  TrueIMPRESSION
//
//  Created by fist on 1/15/14.
//  Copyright (c) 2014 Impression. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface UIFont (TIFonts)

+ (UIFont*)boldFontWithSize:(CGFloat)size;
+ (UIFont*)boldItalicFontWithSize:(CGFloat)size;
+ (UIFont*)extraBoldFontWithSize:(CGFloat)size;
+ (UIFont*)extraBoldItalicFontWithSize:(CGFloat)size;
+ (UIFont*)italicFontWithSize:(CGFloat)size;
+ (UIFont*)lightFontWithSize:(CGFloat)size;
+ (UIFont*)lightItalicFontWithSize:(CGFloat)size;
+ (UIFont*)regularFontWithSize:(CGFloat)size;
+ (UIFont*)semiBoldFontWithSize:(CGFloat)size;
+ (UIFont*)semiBoldItalicFontWithSize:(CGFloat)size;
+ (UIFont*)condBoldFontWithSize:(CGFloat)size;
+ (UIFont*)condLightFontWithSize:(CGFloat)size;
+ (UIFont*)condLightItalicFontWithSize:(CGFloat)size;

@end
