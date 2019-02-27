//
//  listViewController.h
//  EFBE Mess
//
//  Created by Alex Cortes on 11/29/14.
//  Copyright (c) 2014 Alex Cortes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "MyTableViewCell.h"

@interface listViewController : UIViewController <FBLoginViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end


