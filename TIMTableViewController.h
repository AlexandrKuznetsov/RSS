//
//  TIMTableViewController.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 19.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//
@protocol TableDataDelegate <NSObject>
- (void)tableViewForProfessions:(BOOL)isForProfessions pickedData:(NSArray *)data;
@end



#import <UIKit/UIKit.h>
#import "TIMRegistrationModel.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface TIMTableViewController : UITableViewController

@property (assign, nonatomic) BOOL isProfessions;
@property (weak, nonatomic) id <TableDataDelegate> dataDelegate;

@end
