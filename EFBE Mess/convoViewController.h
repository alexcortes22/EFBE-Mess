//
//  convoViewController.h
//  EFBE Mess
//
//  Created by Alex Cortes on 11/29/14.
//  Copyright (c) 2014 Alex Cortes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "MyTableViewCell.h"

@interface convoViewController : UIViewController
//the table view
@property (strong, nonatomic) IBOutlet UITableView *tableView;
//the convo id; given by the previous scene
@property (assign, nonatomic) NSString *convoID;
//the names of the people in the conversation; given by the previous scene
@property (assign, nonatomic) NSString *namesInConvo;
//global array that holds the data
@property (nonatomic, retain) NSArray *theData;
//the naviation bar. Since the application is controlled by a Navigation controller, the navigation bar is needed to move between scenes.
@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;
@property (strong, nonatomic) IBOutlet UITextField *userInput;
@end
