//
//  EmployeeDetailsTableViewCell.h
//  CoreDataDemo
//
//  Created by Pradip Walghude on 2017-18-09.
//  Copyright © 2017   extentia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmployeeDetailsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profilePicImg;
@property (weak, nonatomic) IBOutlet UILabel *employeeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *employeeNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;


@end
