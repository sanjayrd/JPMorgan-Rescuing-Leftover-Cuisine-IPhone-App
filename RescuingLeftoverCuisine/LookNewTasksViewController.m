//
//  LookNewTasksViewController.m
//  RescuingLeftoverCuisine
//
//  Created by Jamal E. Kharrat on 10/24/14.
//  Copyright (c) 2014 Jamal E. Kharrat. All rights reserved.
//

#import "LookNewTasksViewController.h"
#import "TaskDetailViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "PlaceTableViewCell.h"


@interface LookNewTasksViewController (){
    NSMutableArray *tasksArray ;
}

@end

@implementation LookNewTasksViewController


-(void)viewDidAppear:(BOOL)animated{
    
    [_lookupTableView reloadData];
}


-(void)getTasks{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:@"http://ec2-54-204-111-5.compute-1.amazonaws.com:5000/request/getEvents" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSDictionary *dictionary in responseObject){
            [tasksArray addObject:dictionary];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_lookupTableView reloadData];
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc]initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",error.description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        tasksArray = [NSMutableArray new];
    [self getTasks];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"placeCell";
    PlaceTableViewCell *cell = (PlaceTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"PlaceTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
        cell = [[PlaceTableViewCell alloc]init];
    }
    cell.nameLabel.text = [tasksArray[indexPath.row]valueForKey:@"restaurantName"];
    cell.timeLabel.text = [tasksArray[indexPath.row]valueForKey:@"time"];
    
    return cell ;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"showDetail" sender:nil];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  tasksArray.count ;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        TaskDetailViewController *tdvc = [segue destinationViewController];
        tdvc.dictionaryPassed = tasksArray[_lookupTableView.indexPathForSelectedRow.row];
    }

    
    // Pass the selected object to the new view controller.
}


- (IBAction)mapPressed:(id)sender {
    [self performSegueWithIdentifier:@"map" sender:self];
}
@end
