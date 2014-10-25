//
//  LocationTableViewCell.h
//  RescuingLeftoverCuisine
//
//  Created by Jamal E. Kharrat on 10/25/14.
//  Copyright (c) 2014 Jamal E. Kharrat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
