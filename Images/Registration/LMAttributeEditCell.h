//
//  LMAttributeEditCell.h
//  TrueIMPRESSIONS
//
//  Created by Victor Shcherbakov on 09/25/13.
//  Copyright (c) 2013 Victor Shcherbakov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMAttributeEditCell : UITableViewCell{
    NSString* _attributeValue;
    NSString* _attributeTitle;
}

@property NSString* attributeName;
@property NSString* attributeValue;
@property NSString* attributeTitle;

-(IBAction)updateAttributeValue:(id)sender;
-(void)updateControls;

@end
