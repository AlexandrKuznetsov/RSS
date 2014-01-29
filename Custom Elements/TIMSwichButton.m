//
//  TIMSwichButton.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 28.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMSwichButton.h"

@implementation TIMSwichButton

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
        [self setImage:[UIImage imageNamed:@"off.png"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setActive:(BOOL)active {
    _active = active;
    if (_active) {
        [self setImage:[UIImage imageNamed:@"on.png"] forState:UIControlStateNormal];
    } else {
        [self setImage:[UIImage imageNamed:@"off.png"] forState:UIControlStateNormal];

    }
}

@end
