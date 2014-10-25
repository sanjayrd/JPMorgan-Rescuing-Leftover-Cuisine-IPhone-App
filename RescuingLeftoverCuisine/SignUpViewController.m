//
//  SignUpViewController.m
//  RescuingLeftoverCuisine
//
//  Created by Jamal E. Kharrat on 10/24/14.
//  Copyright (c) 2014 Jamal E. Kharrat. All rights reserved.
//

#import "SignUpViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)signUpPressed:(id)sender {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *userinfoDictionary = @{@"firstName" : _firstnameField.text,
                                         @"lastName"  : _lastnameField.text,
                                         @"email"     : _emailField.text,
                                         @"password"  : _passwordField.text,
                                         @"phone"     : _phoneNumberField.text};
    
    
    [manager POST:@"http://ec2-54-204-111-5.compute-1.amazonaws.com:5000/request/addNewUser" parameters:userinfoDictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [manager POST:@"http://ec2-54-204-111-5.compute-1.amazonaws.com:5000/request/validateLogin" parameters:@{@"email"     : _emailField.text,
                                                                                                                 @"password"  : _passwordField.text
                                                                                                                 } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                                                                     [self performSegueWithIdentifier:@"login" sender:self];
                                                                                                                     NSLog(@"%@",responseObject);
                                                                                                                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                                                                     NSLog(@"%@",error.localizedDescription);
                                                                                                                 }];
        
        NSLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    
}
@end
