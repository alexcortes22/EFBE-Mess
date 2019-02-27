//
//  convoViewController.m
//  EFBE Mess
//
//  Created by Alex Cortes on 11/29/14.
//  Copyright (c) 2014 Alex Cortes. All rights reserved.
//

#import "convoViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface convoViewController ()
@property (strong, nonatomic) IBOutlet UINavigationItem *lastPage;

@end

@implementation convoViewController
@synthesize theData;


/*
 
 The method that takes care of the default things i want to do when the scene loads.
 In this case, i want to set the title of the navigation bar to be the names of the people involved
 in this conversation.
 
*/
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];

    _navBar.title = _namesInConvo;
}


/*
 This is a table view delegate method. It adds a row to the table view. The number of rows in the table 
 depends on the number returned by the [numberOfRowsInSection] method. Here i add a custom cell class 
 and i make an API call. The API call will give me the messages in the conversation. I will add a 
 cell for each message.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //my custom cell
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aMessage"];
    if (!cell){
        [tableView registerNib: [UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:@"aMessage"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"aMessage"];
        
    }
    //CGSize maxLabelSize = CGSizeMake(296, 9999);
    //adding the string "/messages" to the convo id.
    NSString *transform = [_convoID stringByAppendingString:@"/messages"];
    
    //---------------------------------The API call------------------------------------------
    [FBRequestConnection startWithGraphPath:transform
                                 parameters: nil
                                 HTTPMethod:@"GET"
                                  completionHandler:^(
                                                      FBRequestConnection *connection, id result, NSError *error)
     {
         if(!error){
             NSArray *info = (NSArray *)[result objectForKey:@"data"];

             for (int i = 0; i < indexPath.row; i++){
                 //get each message object
                 FBGraphObject *current = [info objectAtIndex:i];
                 //the actual message
                 NSString *message = [current objectForKey:@"message"];
                 //the sender object
                 FBGraphObject *sender = [current objectForKey:@"from"];
                 //the name of the sender
                 NSString *name = [sender objectForKey:@"name"];
                 CGSize size = [message sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10.0f]}];
                 CGRect newFrame = cell.firstLabel.frame;
                 newFrame.size.height = size.height;
                 
                 cell.firstLabel.frame = newFrame;
                 cell.secondLabel.frame = newFrame;
                 if([name isEqualToString:@"Alex Cortes"] == true){
                     
                     cell.firstLabel.text = @" ";
                     cell.secondLabel.text = message;
                 }else{
                     cell.firstLabel.text = message;
                     cell.secondLabel.text = @" ";
                 }
             }
         }
         else {
             NSLog(@"ListView error: %@", error.description);
         }

     }];
    
    //-----------------------------------------------------------------------------------------
    return cell;
}


-(NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return 25;
   
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        [self.view setFrame:CGRectMake(0,-220,320,560)];
    }
    else
    {
        [self.view setFrame:CGRectMake(0,-220,320,460)];
    }
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        [self.view setFrame:CGRectMake(0,20,320,560)];
    }
    else
    {
        [self.view setFrame:CGRectMake(0,20,320,460)];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendMessage:(id)sender {
    NSString *theText = self.userInput.text;
//    self.theMessage.text = theText;
    NSMutableString *transform = [NSMutableString stringWithString: _convoID];
    NSLog(@"Whats id? %@", transform);
    [transform appendString:@"/messages"];
    NSLog(@"What request are you making? %@", transform);
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            theText, @"message",
                            nil
                            ];
    /* make the API call */
    [FBRequestConnection startWithGraphPath:transform
                                 parameters:params
                                 HTTPMethod:@"POST"
                          completionHandler:^(
                                              FBRequestConnection *connection,
                                              id result,
                                              NSError *error
                                              ) {
                              /* handle the result */
                              if(!error){
                                  
                              }else{
                                 NSLog(@"Post error: %@", error.description);
                              }
                          }];
   [self.userInput resignFirstResponder];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.userInput resignFirstResponder];
}

@end
