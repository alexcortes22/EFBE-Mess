//
//  MyTableViewCell.h
//  EFBE Mess
//
//  Created by Alex Cortes on 11/30/14.
//  Copyright (c) 2014 Alex Cortes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *firstLabel;
@property (nonatomic, weak) IBOutlet UILabel *secondLabel;


@property NSString *theID;
@property NSString *theNames;
@end

