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
    TIMHomeNavButtonsView *homeBtnView = nib[0];
    [homeBtnView.feedBtnOutlet setImage:[UIImage imageNamed:@"bnt_events_on.png"]
                               forState:UIControlStateHighlighted];
    [homeBtnView.searchBtnOutlet setImage:[UIImage imageNamed:@"btn_search_on.png"]
                                 forState:UIControlStateHighlighted];
    [homeBtnView.friendsBtnOutlet setImage:[UIImage imageNamed:@"btn_friends_on.png"]
                                  forState:UIControlStateHighlighted];
    return homeBtnView;
}

@end
