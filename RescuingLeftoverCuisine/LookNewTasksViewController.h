//
//  LookNewTasksViewController.h
//  RescuingLeftoverCuisine
//
//  Created by Jamal E. Kharrat on 10/24/14.
//  Copyright (c) 2014 Jamal E. Kharrat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookNewTasksViewController : UIViewController <UITableViewDelegate, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *lookupTableView;

- (IBAction)mapPressed:(id)sender;

@end
