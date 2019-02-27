//
//  ViewController.h
//  EFBE Mess
//
//  Created by Alex Cortes on 11/11/14.
//  Copyright (c) 2014 Alex Cortes. All rights reserved.
//
//  This is the header file for the login view scene

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController : UIViewController <FBLoginViewDelegate>
@property (strong, nonatomic) IBOutlet FBLoginView *loginView;

@end

