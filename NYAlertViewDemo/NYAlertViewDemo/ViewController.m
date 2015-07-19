//
//  ViewController.m
//  NYAlertViewDemo
//
//  Created by Nealon Young on 7/18/15.
//  Copyright (c) 2015 Nealon Young. All rights reserved.
//

#import "ViewController.h"

#import "NYAlertViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)systemAlertViewButtonPressed:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Example Title", nil)
                                                                             message:NSLocalizedString(@"Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper.", nil)
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    alertController.view.tintColor = self.view.tintColor;
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          [self dismissViewControllerAnimated:YES completion:nil];
                                                      }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Action 1", nil)
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          [self dismissViewControllerAnimated:YES completion:nil];
                                                      }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Action 2", nil)
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          [self dismissViewControllerAnimated:YES completion:nil];
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)alertViewButtonPressed:(UIButton *)sender {
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    alertViewController.title = NSLocalizedString(@"Example Title", nil);
alertViewController.message = NSLocalizedString(@"Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper.", nil);
    
    alertViewController.buttonCornerRadius = 20.0f;
    alertViewController.view.tintColor = self.view.tintColor;

    alertViewController.titleFont = [UIFont fontWithName:@"AvenirNext-Medium" size:alertViewController.titleFont.pointSize];
    alertViewController.messageFont = [UIFont fontWithName:@"AvenirNext-Regular" size:alertViewController.messageFont.pointSize];
    alertViewController.buttonTitleFont = [UIFont fontWithName:@"AvenirNext-Regular" size:alertViewController.buttonTitleFont.pointSize];
    alertViewController.cancelButtonTitleFont = [UIFont fontWithName:@"AvenirNext-Medium" size:alertViewController.cancelButtonTitleFont.pointSize];
    
    for (int i = 0; i < sender.tag; i++) {
        NSString *actionTitle = [NSString stringWithFormat:NSLocalizedString(@"Action %d", nil), i + 1];
        UIAlertActionStyle actionStyle = UIAlertActionStyleDefault;
        
        if (i == sender.tag - 1) {
            actionTitle = NSLocalizedString(@"Cancel", nil);
            actionStyle = UIAlertActionStyleCancel;
        }
        
        [alertViewController addAction:[NYAlertAction actionWithTitle:actionTitle style:actionStyle handler:^(NYAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
    }
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

@end
