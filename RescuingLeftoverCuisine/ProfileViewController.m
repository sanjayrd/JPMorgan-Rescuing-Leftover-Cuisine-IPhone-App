//
//  ProfileViewController.m
//  RescuingLeftoverCuisine
//
//  Created by Jamal E. Kharrat on 10/25/14.
//  Copyright (c) 2014 Jamal E. Kharrat. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (tableView == _nameTableView) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"John";
                break;
            case 1:
                cell.textLabel.text = @"Doe" ;
            default:
                break;
        }
    }
    else{
        switch (indexPath.row) {
    case 0:
        cell.textLabel.text = @"312-342-4727";
        break;
    case 1:
        cell.textLabel.text = @"jamal7@me.com" ;
    default:
            break;
        }
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"I was selected");
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  2 ;
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

@end
