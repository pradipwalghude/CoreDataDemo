//
//  secondViewController.h
//  CoreDataDemo
//
//  Created by Pradip Walghude on 2017-18-09.
//  Copyright © 2017   extentia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface secondViewController : UIViewController<UITabBarDelegate,UITableViewDataSource>

- (IBAction)actionOnEditButton:(UIButton *)sender;

- (IBAction)actionOnSelectButton:(UIButton *)sender;

@end
