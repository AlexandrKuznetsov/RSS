//
//  UIFont+TIFonts.m
//  TrueIMPRESSION
//
//  Created by fist on 1/15/14.
//  Copyright (c) 2014 Impression. All rights reserved.
//


#import "UIFont+TIFonts.h"


@implementation UIFont (TIFonts)

+ (UIFont*)boldFontWithSize:(CGFloat)size{
    UIFont* font = [UIFont fontWithName:@"OpenSans-Bold" size:size];
    return font;
}

+ (UIFont*)boldItalicFontWithSize:(CGFloat)size{
    UIFont* font = [UIFont fontWithName:@"OpenSans-BoldItalic" size:size];
    return font;
}

+ (UIFont*)extraBoldFontWithSize:(CGFloat)size{
    UIFont* font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:size];
    return font;
}

+ (UIFont*)extraBoldItalicFontWithSize:(CGFloat)size{
    UIFont* font = [UIFont fontWithName:@"OpenSans-ExtraBoldItalic" size:size];
    return font;
}

+ (UIFont*)italicFontWithSize:(CGFloat)size{
    UIFont* font = [UIFont fontWithName:@"OpenSans-Italic" size:size];
    return font;
}

+ (UIFont*)lightFontWithSize:(CGFloat)size{
    UIFont* font = [UIFont fontWithName:@"OpenSans-Light" size:size];
    return font;
}

+ (UIFont*)lightItalicFontWithSize:(CGFloat)size{
    UIFont* font = [UIFont fontWithName:@"OpenSans-LightItalic" size:size];
    return font;
}

+ (UIFont*)regularFontWithSize:(CGFloat)size{
    UIFont* font = [UIFont fontWithName:@"OpenSans-Regular" size:size];
    return font;
}

+ (UIFont*)semiBoldFontWithSize:(CGFloat)size{
    UIFont* font = [UIFont fontWithName:@"OpenSans-Semibold" size:size];
    return font;
}

+ (UIFont*)semiBoldItalicFontWithSize:(CGFloat)size{
    UIFont* font = [UIFont fontWithName:@"OpenSans-SemiboldItalic" size:size];
    return font;
}

+ (UIFont*)condBoldFontWithSize:(CGFloat)size{
    UIFont* font = [UIFont fontWithName:@"OpenSans-CondBold" size:size];
    return font;
}

+ (UIFont*)condLightFontWithSize:(CGFloat)size{
    UIFont* font = [UIFont fontWithName:@"OpenSans-CondLight" size:size];
    return font;
}

+ (UIFont*)condLightItalicFontWithSize:(CGFloat)size{
    UIFont* font = [UIFont fontWithName:@"OpenSans-CondLightItalic" size:size];
    return font;
}

@end
