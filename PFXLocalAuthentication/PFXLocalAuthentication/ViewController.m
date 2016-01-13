//
//  ViewController.m
//  PFXLocalAuthentication
//
//  Created by succorer on 2016. 1. 13..
//  Copyright © 2016년 succorer. All rights reserved.
//

#import "ViewController.h"
#import "PFXLocalAuthentication.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)localAuthenticationButtonTouched:(id)sender {
    [PFXLocalAuthentication canLocalAuthenticationWithCompletion:^{
        [PFXLocalAuthentication evaluateLocalAuthenticationWithCompletion:^{
            NSLog(@"Success Fingerprint authentication");
        } failure:^(NSError *error) {
            [self showPasswordAlert];
        }];
    } failure:^(NSError *error) {
        [self showPasswordAlert];
    }];
}

- (void)showPasswordAlert
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"Password" message:@"Input your password" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelButton = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction * action)
                                       {
                                           [alertViewController dismissViewControllerAnimated:YES completion:nil];
                                           
                                       }];
        
        [alertViewController addAction:cancelButton];
        
        UIAlertAction *confirmButton = [UIAlertAction
                                        actionWithTitle:@"Confirm"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action)
                                        {
                                            [alertViewController dismissViewControllerAnimated:YES completion:nil];
                                            
                                        }];
        
        [confirmButton setEnabled:NO];
        [alertViewController addAction:confirmButton];
        
        [alertViewController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            [textField setSecureTextEntry:YES];
            [textField setPlaceholder:NSLocalizedString(@"password", nil)];
            [textField addTarget:self
                          action:@selector(alertTextFieldDidChange:)
                forControlEvents:UIControlEventEditingChanged];
        }];
        
        [self presentViewController:alertViewController animated:YES completion:nil];
    });
}

- (void)alertTextFieldDidChange:(UITextField *)sender
{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController)
    {
        UITextField *passwordTextField = alertController.textFields.firstObject;
        UIAlertAction *confirmAction = alertController.actions.lastObject;
        confirmAction.enabled = passwordTextField.text.length > 2;
    }
}

@end
