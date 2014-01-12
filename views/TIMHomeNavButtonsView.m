//
//  TIMHomeNavButtonsView.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 13.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMHomeNavButtonsView.h"

@implementation TIMHomeNavButtonsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (TIMHomeNavButtonsView *)loadView {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TIMHomeNavButtonsView"
                                                 owner:self
                                               options:nil];
    return nib[0];
}

@end
