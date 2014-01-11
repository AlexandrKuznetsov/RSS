//
//  LMAttributeEditCell.m
//  TrueIMPRESSIONS
//
//  Created by Victor Shcherbakov on 09/25/13.
//  Copyright (c) 2013 Victor Shcherbakov. All rights reserved.
//

#import "LMAttributeEditCell.h"

@implementation LMAttributeEditCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib{
    if (!self.attributeName) {
        self.attributeName = @"unknownAttribute";
    }
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"LMATTRIBUTE_VALUE_CHANGED" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        if ([self.attributeName isEqualToString:note.userInfo[@"attributeName"]]) {
            self.attributeValue = note.userInfo[@"attributeValue"];
            
            if (note.userInfo[@"attributeTitle"]) {
                self.attributeTitle = note.userInfo[@"attributeTitle"];
            }
        }
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setAttributeValue:(NSString *)attributeValue{
    if (attributeValue && self.attributeName && ![attributeValue isKindOfClass:[NSNull class]]) {
        [[NSUserDefaults standardUserDefaults] setValue:attributeValue
                                                 forKey:self.attributeName];
    }
    
    [self updateControls];
}

-(NSString *)attributeValue{
    return [[NSUserDefaults standardUserDefaults] valueForKey:self.attributeName];
}

-(NSString *)attributeTitle{
    return [[NSUserDefaults standardUserDefaults] valueForKey:[self.attributeName stringByAppendingString:@"-title"]];
}

-(void)setAttributeTitle:(NSString *)attributeTitle{
    if (attributeTitle && self.attributeName && ![attributeTitle isKindOfClass:[NSNull class]]) {
        [[NSUserDefaults standardUserDefaults] setValue:attributeTitle
                                                 forKey:[self.attributeName stringByAppendingString:@"-title"]];
    }
}

-(void)updateAttributeValue:(id)sender{
}

-(void)updateControls{
    
}

@end
