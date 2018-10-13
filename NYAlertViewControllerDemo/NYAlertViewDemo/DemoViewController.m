#import "DemoViewController.h"

#import <MapKit/MapKit.h>
#import "NYAlertViewController.h"

@interface DemoViewController ()

- (void)showStandardAlertView;
- (void)showCustomAlertViewWithActionCount:(NSInteger)actionCount;
- (void)showTextFieldAlertView;
- (void)showMapViewAlertView;
- (void)showDatePickerAlertView;
- (void)showLongMessageAlertView;
- (void)showCustomUIAlertView;

@end

static NSString * const kTableViewCellReuseIdentifier = @"kTableViewCellReuseIdentifier";

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCellReuseIdentifier];
}

- (void)showStandardAlertView {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Example Title", nil)
                                                                             message:NSLocalizedString(@"Nullam id dolor id nibh ultricies vehicula ut id elit. Donec id elit non mi porta gravida at eget metus.", nil)
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Username";
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Password";
        textField.secureTextEntry = YES;
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Destroy", nil)
                                                        style:UIAlertActionStyleDestructive
                                                      handler:^(UIAlertAction *action) {
                                                          [self dismissViewControllerAnimated:YES completion:nil];
                                                      }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          [self dismissViewControllerAnimated:YES completion:nil];
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showCustomAlertViewWithActionCount:(NSInteger)actionCount {
    NSMutableArray<NYAlertAction *> *mutableActions = [NSMutableArray array];

    for (NSInteger i = 0; i < actionCount; i++) {
        NSString *actionTitle = [NSString stringWithFormat:NSLocalizedString(@"Action %d", nil), i + 1];
        UIAlertActionStyle actionStyle = UIAlertActionStyleDefault;

        // Set up the final action as a cancel button
        if (i == actionCount - 1) {
            actionTitle = NSLocalizedString(@"Cancel", nil);
            actionStyle = UIAlertActionStyleCancel;
        }

        [mutableActions addObject:[NYAlertAction actionWithTitle:actionTitle style:actionStyle handler:^(NYAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
    }

    NYAlertViewControllerConfiguration *configuration = [NYAlertViewControllerConfiguration new];
    configuration.transitionStyle = NYAlertViewControllerTransitionStyleFade;
    configuration.backgroundTapDismissalGestureEnabled = YES;
    configuration.swipeDismissalGestureEnabled = YES;
    configuration.alwaysArrangesActionButtonsVertically = YES;

    NSString *title = NSLocalizedString(@"Example Title", nil);
    NSString *message = NSLocalizedString(@"This alert uses the fade transition style! Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Donec id elit non mi porta gravida at eget metus.", nil);

    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithOptions:configuration
                                                                                          title:title
                                                                                        message:message
                                                                                        actions:[NSArray arrayWithArray:mutableActions]];
    alertViewController.view.tintColor = self.view.tintColor;
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

- (void)showTextFieldAlertView {
    NSString *title = NSLocalizedString(@"Login", nil);
    NSString *message = NSLocalizedString(@"The submit action is disabled until text is entered in both text fields", nil);

    NYAlertAction *submitAction = [NYAlertAction actionWithTitle:NSLocalizedString(@"Submit", nil)
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(NYAlertAction *action) {
                                                             [self dismissViewControllerAnimated:YES completion:nil];
                                                         }];
    submitAction.enabled = NO;

    NYAlertAction *cancelAction = [NYAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(NYAlertAction *action) {
                                                             [self dismissViewControllerAnimated:YES completion:nil];
                                                         }];
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithOptions:nil
                                                                                          title:title
                                                                                        message:message
                                                                                        actions:@[submitAction, cancelAction]];

    // Disable the submit action until the user has filled out both text fields
    [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      UITextField *usernameTextField = [alertViewController.textFields firstObject];
                                                      UITextField *passwordTextField = [alertViewController.textFields lastObject];
                                                      
                                                      submitAction.enabled = ([usernameTextField.text length] && [passwordTextField.text length]);
                                                  }];

    [alertViewController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"Username", nil);
    }];
    
    [alertViewController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"Password", nil);
        textField.secureTextEntry = YES;
    }];

    [self presentViewController:alertViewController animated:YES completion:nil];
}

- (void)showMapViewAlertView {
    NSString *title = NSLocalizedString(@"Content View", nil);
    NSString *message = NSLocalizedString(@"Set the alertViewContentView property to add custom views to the alert view", nil);
    NYAlertAction *deleteAction = [NYAlertAction actionWithTitle:NSLocalizedString(@"Delete", nil)
                                                           style:UIAlertActionStyleDestructive
                                                         handler:^(NYAlertAction *action) {
                                                             [self dismissViewControllerAnimated:YES completion:nil];
                                                         }];
    NYAlertAction *cancelAction = [NYAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(NYAlertAction *action) {
                                                             [self dismissViewControllerAnimated:YES completion:nil];
                                                         }];
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithOptions:nil
                                                                                          title:title
                                                                                        message:message
                                                                                        actions:@[deleteAction, cancelAction]];

    UIView *contentView = [[UIView alloc] initWithFrame:CGRectZero];
    
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectZero];
    [mapView setTranslatesAutoresizingMaskIntoConstraints:NO];
    mapView.zoomEnabled = NO;
    mapView.scrollEnabled = NO;
    mapView.layer.cornerRadius = 6.0f;
    
    CLLocationCoordinate2D infiniteLoopCoordinate = CLLocationCoordinate2DMake(37.331693, -122.030457);
    mapView.region = MKCoordinateRegionMakeWithDistance(infiniteLoopCoordinate, 1000.0f, 1000.0f);
    [contentView addSubview:mapView];
    
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mapView(160)]|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:NSDictionaryOfVariableBindings(mapView)]];

    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[mapView]-|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:NSDictionaryOfVariableBindings(mapView)]];
    
    alertViewController.alertViewContentView = contentView;
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

- (void)showDatePickerAlertView {
    NSString *title = NSLocalizedString(@"Content View", nil);
    NSString *message = NSLocalizedString(@"Set the alertViewContentView property to add custom views to the alert view", nil);
    NYAlertAction *selectAction = [NYAlertAction actionWithTitle:NSLocalizedString(@"Select", nil)
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(NYAlertAction *action) {
                                                         [self dismissViewControllerAnimated:YES completion:nil];
                                                     }];
    NYAlertAction *cancelAction = [NYAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(NYAlertAction *action) {
                                                             [self dismissViewControllerAnimated:YES completion:nil];
                                                         }];
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithOptions:nil
                                                                                          title:title
                                                                                        message:message
                                                                                        actions:@[selectAction, cancelAction]];
    
//    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Select", nil)
//                                                            style:UIAlertActionStyleDefault
//                                                          handler:^(NYAlertAction *action) {
//                                                              [self dismissViewControllerAnimated:YES completion:nil];
//                                                          }]];
//
//    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
//                                                            style:UIAlertActionStyleCancel
//                                                          handler:^(NYAlertAction *action) {
//                                                              [self dismissViewControllerAnimated:YES completion:nil];
//                                                          }]];

    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    
    alertViewController.alertViewContentView = datePicker;
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

- (void)showLongMessageAlertView {
    NYAlertViewControllerConfiguration *configuration = [NYAlertViewControllerConfiguration new];
    configuration.transitionStyle = NYAlertViewControllerTransitionStyleSlideFromBottom;
    NSString *title = NSLocalizedString(@"Long Message", nil);
    NSString *message = NSLocalizedString(@"This alert view uses the slide from bottom transition style!\n\nNullam id dolor id nibh ultricies vehicula ut id elit. Donec id elit non mi porta gravida at eget metus. Maecenas faucibus mollis interdum. Donec id elit non mi porta gravida at eget metus. Aenean lacinia bibendum nulla sed consectetur. Nullam id dolor id nibh ultricies vehicula ut id elit. Donec ullamcorper nulla non metus auctor fringilla. Nulla vitae elit libero, a pharetra augue. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Nullam id dolor id nibh ultricies vehicula ut id elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Donec id elit non mi porta gravida at eget metus. Etiam porta sem malesuada magna mollis euismod. Curabitur blandit tempus porttitor. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Donec ullamcorper nulla non metus auctor fringilla. Nullam quis risus eget urna mollis ornare vel eu leo. Etiam porta sem malesuada magna mollis euismod. Maecenas faucibus mollis interdum. Maecenas sed diam eget risus varius blandit sit amet non magna.", nil);

    NSArray<NYAlertAction *> *actions = @[[NYAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(NYAlertAction *action) {
                                                                     [self dismissViewControllerAnimated:YES completion:nil];
                                                                 }]];

    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithOptions:configuration
                                                                                          title:title
                                                                                        message:message
                                                                                        actions:actions];
    [self presentViewController:alertViewController animated:YES completion:nil];
}

- (void)showCustomUIAlertView {
    NYAlertActionConfiguration *buttonConfiguration = [NYAlertActionConfiguration new];
    buttonConfiguration.titleColor = [UIColor colorWithRed:0.42f green:0.78 blue:0.32f alpha:1.0f];
    buttonConfiguration.titleFont = [UIFont fontWithName:@"AvenirNext-Medium" size:19.0f];

    NYAlertActionConfiguration *cancelButtonConfiguration = [NYAlertActionConfiguration new];
    cancelButtonConfiguration.titleColor = [UIColor lightGrayColor];
    cancelButtonConfiguration.titleFont = [UIFont fontWithName:@"AvenirNext-Regular" size:17.0f];

    NYAlertViewControllerConfiguration *configuration = [NYAlertViewControllerConfiguration new];
    configuration.buttonConfiguration = buttonConfiguration;
    configuration.cancelButtonConfiguration = cancelButtonConfiguration;
    configuration.alertViewBackgroundColor = [UIColor colorWithWhite:0.19f alpha:1.0f];
    configuration.showsSeparators = NO;
    configuration.titleFont = [UIFont fontWithName:@"AvenirNext-Bold" size:18.0f];
    configuration.messageFont = [UIFont fontWithName:@"AvenirNext-Medium" size:16.0f];
    configuration.alertViewCornerRadius = 10.0f;
    configuration.backgroundTapDismissalGestureEnabled = YES;
    configuration.swipeDismissalGestureEnabled = YES;
    configuration.alwaysArrangesActionButtonsVertically = YES;
    configuration.titleTextColor = [UIColor colorWithRed:0.42f green:0.78 blue:0.32f alpha:1.0f];
    configuration.messageTextColor = [UIColor colorWithWhite:0.92f alpha:1.0f];

    NSString *title = NSLocalizedString(@"Custom UI", nil);
    NSString *message = NSLocalizedString(@"Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Donec id elit non mi porta gravida at eget metus.", nil);
    NYAlertAction *okAction = [NYAlertAction actionWithTitle:NSLocalizedString(@"Subscribe", nil)
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(NYAlertAction *action) {
                                                         [self dismissViewControllerAnimated:YES completion:nil];
                                                     }];
    NYAlertAction *cancelAction = [NYAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(NYAlertAction *action) {
                                                             [self dismissViewControllerAnimated:YES completion:nil];
                                                         }];
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithOptions:configuration
                                                                                          title:title
                                                                                        message:message
                                                                                        actions:@[okAction, cancelAction]];
    
    alertViewController.view.tintColor = self.view.tintColor;
    
    alertViewController.buttonColor = [UIColor colorWithRed:0.42f green:0.78 blue:0.32f alpha:1.0f];
    
    alertViewController.cancelButtonColor = [UIColor colorWithRed:0.42f green:0.78 blue:0.32f alpha:1.0f];
    
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
            [self showTextFieldAlertView];
            break;
            
        case 5:
            [self showMapViewAlertView];
            break;
            
        case 6:
            [self showDatePickerAlertView];
            break;
            
        case 7:
            [self showLongMessageAlertView];
            break;
            
        case 8:
            [self showCustomUIAlertView];
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
