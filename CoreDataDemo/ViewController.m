//
//  ViewController.m
//  CoreDataDemo
//
//  Created by Pradip Walghude on 2017-18-09.
//  Copyright © 2017   extentia. All rights reserved.
//

#import "ViewController.h"
#import "AppManager.h"
#import "secondViewController.h"

@interface ViewController ()
{
    
}
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *email;

@property (weak, nonatomic) IBOutlet UITextField *mobile;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImageview;

- (IBAction)actionOnProfilePictureButton:(UIButton *)sender;


- (IBAction)actionOnSubmitBtn:(UIButton *)sender;

@end

@implementation ViewController

#pragma mark- View Life cycle methods
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _email.text = @"  pradipwalghude@gmail.com";
//    _name.text = @"  Pradip Walghude";
//    _mobile.text = @"  9762953471";
//
    _profilePicImageview.layer.cornerRadius = _profilePicImageview.frame.size.width/2;
    _profilePicImageview.clipsToBounds = YES;
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Button Actions
- (IBAction)actionOnProfilePictureButton:(UIButton *)sender {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Profile photo"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *button1 = [UIAlertAction actionWithTitle:@"Take photo" style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * action) {
                                                        //code to run once button is pressed
                                                        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                                                        {
                                       //                     [[Utilities utilities] showToastMessage:@"It seems there is no camera for your device." OnView:self.view];
                                                        }
                                                        else // for taking a photo
                                                        {
                                                            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                                                            [self presentViewController:imagePickerController animated:YES completion:NULL];
                                                        }
                                                        
                                                    }];
    UIAlertAction *button2 = [UIAlertAction actionWithTitle:@"Choose existing" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //code to run once button is pressed
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //code to run once button is pressed
    }];
    
    [alert addAction:button1];
    [alert addAction:button2];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)actionOnSubmitBtn:(UIButton *)sender {
    int eID = 0;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"employeeID"] != nil) {
        //key exists
        int employeeID = [[NSUserDefaults standardUserDefaults] integerForKey:@"employeeID"];
        eID = employeeID + 1;
        [[NSUserDefaults standardUserDefaults] setInteger:eID forKey:@"employeeID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
        
        
    
    
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithCapacity:0];
    [paramDict setObject:_name.text forKey:@"name"];
    [paramDict setObject:_email.text forKey:@"email"];
    [paramDict setObject:_mobile.text forKey:@"mobile"];
    [paramDict setObject:[NSString stringWithFormat:@"%d",eID] forKey:@"id"];
    NSData * imageData = UIImagePNGRepresentation(_profilePicImageview.image);
    [paramDict setValue:imageData forKey:@"imageData"];
    
    [[AppManager sharedDBManager] saveDataInDB:paramDict ];
    
    secondViewController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"SVC"];
    [self.navigationController pushViewController:svc animated:YES];
}


#pragma mark - UIImagePicker Delegates

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker1 {
    
    [picker1 dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // Images from the camera are always in landscape, so rotate
    UIImage *chosenImage =  [info objectForKey:UIImagePickerControllerOriginalImage];
    _profilePicImageview.image = chosenImage;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
    
@end
