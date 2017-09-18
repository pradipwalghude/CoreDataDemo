//
//  secondViewController.m
//  CoreDataDemo
//
//  Created by Pradip Walghude on 2017-18-09.
//  Copyright © 2017   extentia. All rights reserved.
//

#import "secondViewController.h"
#import "AppManager.h"
#import "Employee+CoreDataClass.h"
#import "EmployeeDetailsTableViewCell.h"

@interface secondViewController ()
{
    NSArray *employeeData;
}

@end

@implementation secondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *empData = [[AppManager sharedDBManager] getEmployeeName:[NSNumber numberWithInteger:1]];
    NSLog(@"%@",empData);
    
    
    NSArray *empEmail = [[AppManager sharedDBManager] getEmployeeEmailID];
    NSLog(@"All Employees email%@",empEmail);
    
    Employee *employee  ;
    for (employee in empEmail) {
        
        NSLog(@"%@",employee.eemail);
    }
    
     employeeData = [[AppManager sharedDBManager] getEmployeeEmailID];
     NSLog(@"%@",employeeData);
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Table View delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return employeeData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    Employee *employee;
    EmployeeDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[EmployeeDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    employee = [employeeData objectAtIndex:indexPath.row];
    cell.employeeNameLabel.text = employee.ename;
    cell.employeeNumberLabel.text = employee.emobile;
    cell.profilePicImg.image = [UIImage imageWithData:employee.imageData];
    
    cell.profilePicImg.layer.cornerRadius = cell.profilePicImg.frame.size.width/2;
    cell.profilePicImg.clipsToBounds = YES;
    
    return cell;
}

- (IBAction)actionOnEditButton:(UIButton *)sender {
    
}

- (IBAction)actionOnSelectButton:(UIButton *)sender {
}
@end
