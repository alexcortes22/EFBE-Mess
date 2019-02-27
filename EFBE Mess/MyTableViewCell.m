//
//  MyTableViewCell.m
//  EFBE Mess
//
//  Created by Alex Cortes on 11/30/14.
//  Copyright (c) 2014 Alex Cortes. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

@synthesize firstLabel, secondLabel;


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
