//
//  ViewController.m
//  RescuingLeftoverCuisine
//
//  Created by Jamal E. Kharrat on 10/24/14.
//  Copyright (c) 2014 Jamal E. Kharrat. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated{
    
    _loginButton.enabled = NO ;
    _loginButton.alpha = 0.4 ;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [_usernameField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [_passwordField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)textFieldDidChange{
    if (_usernameField.text.length > 4 && _passwordField.text.length > 4) {
        _loginButton.enabled = YES;
           _loginButton.alpha = 1 ;
    }else {
        _loginButton.enabled = NO ;
        _loginButton.alpha = 0.4;
    }
}


- (IBAction)loginButtonPressed:(id)sender {
    //login
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:@"http://ec2-54-204-111-5.compute-1.amazonaws.com:5000/request/validateLogin" parameters:@{@"email" : _usernameField.text , @"password" : _passwordField.text } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
        [self performSegueWithIdentifier:@"showPlaces" sender:self];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:_usernameField.text forKey:@"email"];
        [userDefaults synchronize];
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error.localizedDescription);
            [[[UIAlertView alloc]initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",error.localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
            
        }];

}

- (IBAction)signupButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"signUp" sender:self];
}

- (IBAction)backgroundTouched:(id)sender {
    [_usernameField resignFirstResponder];
    [_passwordField resignFirstResponder];
    
}
@end
