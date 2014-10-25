//
//  MainViewController.m
//  RescuingLeftoverCuisine
//
//  Created by Jamal E. Kharrat on 10/24/14.
//  Copyright (c) 2014 Jamal E. Kharrat. All rights reserved.
//

#import "MainViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "TaskTableViewCell.h"

@interface MainViewController (){
    NSMutableArray *tasksArray ;
}

@end

@implementation MainViewController


- (void)viewDidAppear:(BOOL)animated{

    [self getTasks];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
}

-(void)getTasks{
    tasksArray = [NSMutableArray new];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:@"http://ec2-54-204-111-5.compute-1.amazonaws.com:5000/request/getSignedUpEvents" parameters:@{@"email" : [[NSUserDefaults standardUserDefaults]valueForKey:@"email"]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        for (NSDictionary *tasksDictionary in responseObject){
            [tasksArray addObject:tasksDictionary];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            _noItemsView.hidden = YES ;
            [_placesTableView reloadData];
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    for (NSInteger idx = 0; idx< 10; idx++) {
//        [tasksArray addObject:[NSString stringWithFormat:@"String %i", idx]];
//    }
    if (tasksArray.count == 0) {
       [UIView animateWithDuration:0.4 animations:^{
            _noItemsView.alpha = 1 ;
        }];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    TaskTableViewCell *cell = (TaskTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"TaskTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
        cell = [[TaskTableViewCell alloc]init];
    }
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ -> %@",tasksArray[indexPath.row][@"restaurantName"], tasksArray[indexPath.row][@"shelterName"]];
    cell.weightLabel.text = tasksArray[indexPath.row][@"time"];
    
    
    return cell ;
    
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"I was selected");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  tasksArray.count ;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"search" sender:self];
}

- (IBAction)profileButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"showProfile" sender:self];
}
@end
