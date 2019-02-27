//
//  ViewController.m
//  EFBE Mess
//
//  Created by Alex Cortes on 11/11/14.
//  Copyright (c) 2014 Alex Cortes. All rights reserved.
//
//  The implentation for the login view scene file

#import "ViewController.h"



@interface ViewController ()
@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePic;
@property (strong, nonatomic) IBOutlet UINavigationItem *nextPage;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //These are the permissions i want for the application. When the
    //user logs in for the first time, he/she will be asked to accept these permissions.
    self.loginView.readPermissions = @[@"public_profile", @"read_mailboxes", @"read_page_mailbox"];
    //self.loginView.p
}

-(void)viewDidAppear:(BOOL)animated
{
    //if the fb session is open just seque unto the next scene.
    if (FBSession.activeSession.isOpen == true)
    [self performSegueWithIdentifier:@"nextScene" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//show the profile pic of the user.
-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    self.profilePic.profileID = user.objectID;
}

//a method to check the permission i want are acquired. If not, we ask again.
-(void)checkPermissions: (id)user {
    //the permissions i want.
    NSArray *permissionsDesired = @[@"public_profile", @"read_mailbox", @"read_page_mailboxes"];
    
    //request the fb api for the permissions i currently have
    //----------------------------------------FB API CALL----------------------------------------
    [FBRequestConnection startWithGraphPath:@"/me/permissions"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error)
                            {
        if (!error) {
            NSDictionary *currentPermissions = [(NSArray *) [result data] objectAtIndex:0];
            NSLog(@"current permissions %@", currentPermissions);
            NSMutableArray *requestPermissions = [[NSMutableArray alloc] initWithArray: @[]];
            
            //check if permissions we need are in currentPermissions. If they aren't, add to
            //requestPermissions
            
            for(NSString *permission in permissionsDesired){
                if (![currentPermissions objectForKey:permission]){
                    [requestPermissions addObject:permission];
                }
            }
            
            //If we have permissions to request
            if ([requestPermissions count] > 0){
                //ask for the permissions again
                [FBSession.activeSession requestNewReadPermissions:requestPermissions completionHandler:
                 ^(FBSession *session, NSError *error)
                 {
                     if (!error) {
                         //permission(s) granted
                         NSLog(@"new permissions %@", [FBSession.activeSession permissions]);
                    }
                     else {
                         //an error occured
                         NSLog(@"error %@", error.description);
                     }
                 }
                 ];
                
            } else {
                //nothing
            }
        } else {
            NSLog(@"error %@", error.description);
        }
    }];
   //-----------------------------------------------------------------------------------------
}
@end
