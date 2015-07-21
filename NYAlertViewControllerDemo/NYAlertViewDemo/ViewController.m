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

- (void)showCustomAlertViewWithActionCount:(NSInteger)actionCount;
- (void)showLongMessageAlertView;
- (void)showCustomUIAlertView;

@end

typedef NS_ENUM(NSInteger, AlertExampleTableViewSection) {
    AlertExampleTableViewSectionStandard = 0,
    AlertExampleTableViewSectionCustom,
    ALERT_EXAMPLE_TABLE_VIEW_SECTION_COUNT
};

typedef NS_ENUM(NSInteger, StandardAlertTableViewRow) {
    StandardAlertTableViewRowNoActions = 0,
    STANDARD_ALERT_TABLE_VIEW_USER_ROW_COUNT
};

typedef NS_ENUM(NSInteger, CustomAlertTableViewRow) {
    CustomAlertTableViewRowNoActions = 0,
    CustomAlertTableViewRowLongMessage,
    CustomAlertTableViewRow1Action,
    CustomAlertTableViewRow2Actions,
    CustomAlertTableViewRow3Actions,
    CustomAlertTableViewRowExample1,
    CUSTOM_ALERT_TABLE_VIEW_USER_ROW_COUNT
};

static NSString * const kTableViewCellReuseIdentifier = @"kTableViewCellReuseIdentifier";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCellReuseIdentifier];
}

- (void)showStandardAlertView {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Example Title", nil)
                                                                             message:NSLocalizedString(@"Nullam id dolor id nibh ultricies vehicula ut id elit. Donec id elit non mi porta gravida at eget metus. Maecenas faucibus mollis interdum. Donec id elit non mi porta gravida at eget metus. Aenean lacinia bibendum nulla sed consectetur. Nullam id dolor id nibh ultricies vehicula ut id elit. Donec ullamcorper nulla non metus auctor fringilla. Nulla vitae elit libero, a pharetra augue. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Nullam id dolor id nibh ultricies vehicula ut id elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.", nil)
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    alertController.view.tintColor = self.view.tintColor;
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          [self dismissViewControllerAnimated:YES completion:nil];
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showCustomAlertViewWithActionCount:(NSInteger)actionCount {
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    alertViewController.title = NSLocalizedString(@"Example Title", nil);
alertViewController.message = NSLocalizedString(@"Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Donec id elit non mi porta gravida at eget metus.", nil);
    
    alertViewController.view.tintColor = self.view.tintColor;

    alertViewController.titleFont = [UIFont fontWithName:@"AvenirNext-Bold" size:alertViewController.titleFont.pointSize];
    alertViewController.messageFont = [UIFont fontWithName:@"AvenirNext-Regular" size:alertViewController.messageFont.pointSize];
    alertViewController.buttonTitleFont = [UIFont fontWithName:@"AvenirNext-Regular" size:alertViewController.buttonTitleFont.pointSize];
    alertViewController.cancelButtonTitleFont = [UIFont fontWithName:@"AvenirNext-Medium" size:alertViewController.cancelButtonTitleFont.pointSize];
    
    for (int i = 0; i < actionCount; i++) {
        NSString *actionTitle = [NSString stringWithFormat:NSLocalizedString(@"Action %d", nil), i + 1];
        UIAlertActionStyle actionStyle = UIAlertActionStyleDefault;
        
        if (i == actionCount - 1) {
            actionTitle = NSLocalizedString(@"Cancel", nil);
            actionStyle = UIAlertActionStyleCancel;
        }
        
        [alertViewController addAction:[NYAlertAction actionWithTitle:actionTitle style:actionStyle handler:^(NYAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
    }
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

- (void)showLongMessageAlertView {
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];

    alertViewController.title = NSLocalizedString(@"Long Message", nil);
    alertViewController.message = NSLocalizedString(@"Nullam id dolor id nibh ultricies vehicula ut id elit. Donec id elit non mi porta gravida at eget metus. Maecenas faucibus mollis interdum. Donec id elit non mi porta gravida at eget metus. Aenean lacinia bibendum nulla sed consectetur. Nullam id dolor id nibh ultricies vehicula ut id elit. Donec ullamcorper nulla non metus auctor fringilla. Nulla vitae elit libero, a pharetra augue. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Nullam id dolor id nibh ultricies vehicula ut id elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Donec id elit non mi porta gravida at eget metus. Etiam porta sem malesuada magna mollis euismod. Curabitur blandit tempus porttitor. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Donec ullamcorper nulla non metus auctor fringilla.", nil);
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(NYAlertAction *action) {
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

- (void)showCustomUIAlertView {
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];

    alertViewController.title = NSLocalizedString(@"Custom UI", nil);
    alertViewController.message = NSLocalizedString(@"Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Donec id elit non mi porta gravida at eget metus.", nil);
    
    alertViewController.buttonCornerRadius = 20.0f;
    alertViewController.view.tintColor = self.view.tintColor;
    
    alertViewController.titleFont = [UIFont fontWithName:@"AvenirNext-Bold" size:19.0f];
    alertViewController.messageFont = [UIFont fontWithName:@"AvenirNext-Medium" size:16.0f];
    alertViewController.buttonTitleFont = [UIFont fontWithName:@"AvenirNext-Regular" size:alertViewController.buttonTitleFont.pointSize];
    alertViewController.cancelButtonTitleFont = [UIFont fontWithName:@"AvenirNext-Medium" size:alertViewController.cancelButtonTitleFont.pointSize];
    
    alertViewController.alertViewBackgroundColor = [UIColor colorWithWhite:0.19f alpha:1.0f];
    alertViewController.alertViewCornerRadius = 10.0f;
    
    alertViewController.titleColor = [UIColor colorWithRed:0.42f green:0.78 blue:0.32f alpha:1.0f];
    alertViewController.messageColor = [UIColor colorWithWhite:0.92f alpha:1.0f];
    alertViewController.cancelButtonColor = [UIColor colorWithRed:0.42f green:0.78 blue:0.32f alpha:1.0f];
    alertViewController.cancelButtonTitleColor = [UIColor colorWithWhite:0.19f alpha:1.0f];
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Done", nil)
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(NYAlertAction *action) {
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self showCustomAlertViewWithActionCount:0];
            break;
            
        case 1:
            [self showCustomAlertViewWithActionCount:1];
            break;
            
        case 2:
            [self showCustomAlertViewWithActionCount:2];
            break;
            
        case 3:
            [self showCustomAlertViewWithActionCount:3];
            break;
            
        case 4:
            [self showLongMessageAlertView];
            break;
            
        case 5:
            [self showCustomUIAlertView];
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
