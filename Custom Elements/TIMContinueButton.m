//
//  TIMContinueButton.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 14.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMContinueButton.h"

@implementation TIMContinueButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        UIImage *backgroundImage = [[UIImage imageNamed:@"btn_green.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(16, 28, 16, 28)];
        [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    }
    return self;
}

@end
