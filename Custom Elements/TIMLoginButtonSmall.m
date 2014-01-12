//
//  TIMLoginButtonSmall.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 12.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMLoginButtonSmall.h"

@implementation TIMLoginButtonSmall

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
        [self setImage:[UIImage imageNamed:@"login-button-down"]
              forState:UIControlStateHighlighted];
    }
    return self;
}

@end
