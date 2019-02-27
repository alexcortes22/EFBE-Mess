//
//  listViewController.m
//  EFBE Mess
//
//  Created by Alex Cortes on 11/29/14.
//  Copyright (c) 2014 Alex Cortes. All rights reserved.
//

#import "listViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "MyTableViewCell.h"
#import "convoViewController.h"


@interface listViewController ()

@property NSArray *conversations;
@property int num;
@property (strong, nonatomic) IBOutlet UINavigationItem *nextPage;

@end

@implementation listViewController


//NSArray *currentconvos;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//setting the number of rows in the table view
-(NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 10;
    //NSLog(@"The property in the bottom method:? %d", _num);
    return 25;
}

/*
This is a table view delegate method. It adds a row to the table view. The number of rows in the table
depends on the number returned by the [numberOfRowsInSection] method. Here i add a custom cell class
and i make an API call. The API call will give me the conversations in my inbox. I will add a
cell for each conversation.
*/
- (UITableViewCell *)tableView:(UITableView *)tableView
cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aFriend"];
    if (!cell){
        [tableView registerNib: [UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:@"aFriend"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"aFriend"];
    }
    
    //-----------------------------FB API CALL----------------------------------------------
    [FBRequestConnection startWithGraphPath:@"/me/conversations"
                                 parameters: nil
                                 HTTPMethod:@"GET"
                          completionHandler: ^(
                                               FBRequestConnection *connection, id result, NSError *error)
     {
         if (!error)
         {
             
             //get the data from the result. Its an array
             NSArray *item = (NSArray *)[result objectForKey:@"data"];
             //for each conversation:
             for (int i = 0; i <= indexPath.row; i++) {
                 NSMutableString *convoLabel =  [NSMutableString string];
                 //get the current graph object
                 FBGraphObject *current = [item objectAtIndex:i];
                 //get the convo id of each convo
                 NSString *convoID = [current objectForKey:@"id"];
                 cell.theID = convoID;
                 //get the participants of each convo
                 FBGraphObject *participants = [current objectForKey:@"participants"];
                 //get the data of the participants
                 NSArray *data = (NSArray *)[participants objectForKey:@"data"];
                 //for each participants
                 for(int i = 0; i < data.count; i++){
                     //get the information
                     FBGraphObject *now = [data objectAtIndex:i];
                     //get the name of participant
                     NSString *name = [now objectForKey:@"name"];
                     if([name isEqualToString:@"Alex Cortes"] == false){
                         [convoLabel appendString:[name stringByAppendingString:@","]];
                     }
                }
                 cell.firstLabel.text = convoLabel;
                 cell.theNames = convoLabel;
                
             }
             
     
         }
         else {
             NSLog(@"ListView error: %@", error.description);
         }
     }];
    //--------------------------------------------------------------------------------------
    cell.secondLabel.text = @"";
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"pushToConvo"]){
        // Get the new view controller using
        convoViewController *convo = [segue destinationViewController];
        //the index path for the selectedRow
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //the selected cell
        MyTableViewCell *selectedCell = (MyTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        
        convo.convoID = selectedCell.theID;
        convo.namesInConvo = selectedCell.theNames;
    }

}


@end
