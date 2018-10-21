#import "DemoViewController.h"

#import <MapKit/MapKit.h>
#import "NYAlertViewController.h"

@interface DemoItem: NSObject

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NYAlertViewController *alertViewController;

- (instancetype)initWithTitle:(NSString *)title alertViewController:(NYAlertViewController *)alertViewController;

@end

@implementation DemoItem

- (instancetype)initWithTitle:(NSString *)title alertViewController:(NYAlertViewController *)alertViewController {
    self = [super init];

    if (self) {
        _title = title;
        _alertViewController = alertViewController;
    }

    return self;
}

@end

@interface DemoViewController ()

@property (nonatomic, strong) NSArray<DemoItem *> *demoItems;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"NYAlertViewController";

    self.demoItems = @[[[DemoItem alloc] initWithTitle:@"No Actions" alertViewController:[self createCustomAlertViewWithActionCount:0]],
                       [[DemoItem alloc] initWithTitle:@"1 Action" alertViewController:[self createCustomAlertViewWithActionCount:1]],
                       [[DemoItem alloc] initWithTitle:@"2 Actions" alertViewController:[self createCustomAlertViewWithActionCount:2]],
                       [[DemoItem alloc] initWithTitle:@"3 Actions" alertViewController:[self createCustomAlertViewWithActionCount:3]],
                       [[DemoItem alloc] initWithTitle:@"Text Fields" alertViewController:[self createTextFieldAlertView]],
                       [[DemoItem alloc] initWithTitle:@"Long Message" alertViewController:[self createLongMessageAlertView]],
                       [[DemoItem alloc] initWithTitle:@"Custom Content View" alertViewController:[self createMapViewAlertView]],
                       [[DemoItem alloc] initWithTitle:@"Custom Fonts" alertViewController:[self createCustomFontAlertView]],
                       [[DemoItem alloc] initWithTitle:@"Banner Image" alertViewController:[self createBannerImageAlertView]],
                       [[DemoItem alloc] initWithTitle:@"Icon Image" alertViewController:[self createIconImageAlertView]],
                       [[DemoItem alloc] initWithTitle:@"Dark Style" alertViewController:[self createDarkIconImageAlertView]]];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (void)showStandardAlertView {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Example Title"
                                                                             message:@"Nullam id dolor id nibh ultricies vehicula ut id elit. Donec id elit non mi porta gravida at eget metus."
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Username";
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Password";
        textField.secureTextEntry = YES;
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Destroy"
                                                        style:UIAlertActionStyleDestructive
                                                      handler:nil]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                        style:UIAlertActionStyleCancel
                                                      handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Demo Alert Views

- (NYAlertViewController *)createBannerImageAlertView {
    NSString *title = @"Banner Image";
    NSString *message = @"Set the alertViewContentView property to add custom views to the alert view";
    NYAlertAction *cancelAction = [NYAlertAction actionWithTitle:@"Later"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];

    NYAlertAction *okAction = [NYAlertAction actionWithTitle:@"Ok"
                                                       style:UIAlertActionStyleCancel
                                                     handler:nil];

    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithOptions:nil
                                                                                          title:title
                                                                                        message:message
                                                                                        actions:@[cancelAction, okAction]];

    UIImageView *bannerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BannerImage"]];
    bannerImageView.clipsToBounds = YES;
    bannerImageView.contentMode = UIViewContentModeScaleAspectFill;
    [bannerImageView.heightAnchor constraintEqualToConstant:120.0f].active = YES;
    alertViewController.alertViewContentView = bannerImageView;

    return alertViewController;
}

- (NYAlertViewController *)createIconImageAlertView {
    NSString *title = @"Location Permission";
    NSString *message = @"Set the alertViewContentView property to add custom views to the alert view";
    NYAlertAction *cancelAction = [NYAlertAction actionWithTitle:@"Later"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];

    NYAlertAction *okAction = [NYAlertAction actionWithTitle:@"Ok"
                                                       style:UIAlertActionStyleCancel
                                                     handler:nil];

    NYAlertViewControllerConfiguration *configuration = [NYAlertViewControllerConfiguration new];
    configuration.contentViewInset = UIEdgeInsetsMake(12.0f, 8.0f, 8.0f, 8.0f);

    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithOptions:configuration
                                                                                          title:title
                                                                                        message:message
                                                                                        actions:@[cancelAction, okAction]];

    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MapIcon"]];
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [iconImageView.heightAnchor constraintEqualToConstant:60.0f].active = YES;
    alertViewController.alertViewContentView = iconImageView;

    return alertViewController;
}

- (NYAlertViewController *)createDarkIconImageAlertView {
    NSString *title = @"Location Permission";
    NSString *message = @"Set the alertViewContentView property to add custom views to the alert view";
    NYAlertAction *cancelAction = [NYAlertAction actionWithTitle:@"Later"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];

    NYAlertAction *okAction = [NYAlertAction actionWithTitle:@"Ok"
                                                       style:UIAlertActionStyleCancel
                                                     handler:nil];

    NYAlertViewControllerConfiguration *configuration = [NYAlertViewControllerConfiguration new];
    configuration.contentViewInset = UIEdgeInsetsMake(12.0f, 8.0f, 8.0f, 8.0f);
    configuration.alertViewBackgroundColor = [UIColor colorWithRed:0.23f green:0.23f blue:0.27f alpha:1.0f];
    configuration.separatorColor = [UIColor colorWithRed:0.16f green:0.16f blue:0.2f alpha:1.0f];
    configuration.titleTextColor = [UIColor whiteColor];
    configuration.messageTextColor = [UIColor whiteColor];

    configuration.buttonConfiguration = [NYAlertActionConfiguration new];
    configuration.buttonConfiguration.titleColor = [UIColor whiteColor];

    configuration.cancelButtonConfiguration.titleColor = [UIColor whiteColor];

    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithOptions:configuration
                                                                                          title:title
                                                                                        message:message
                                                                                        actions:@[cancelAction, okAction]];

    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MapIcon"]];
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [iconImageView.heightAnchor constraintEqualToConstant:60.0f].active = YES;
    alertViewController.alertViewContentView = iconImageView;

    return alertViewController;
}

- (NYAlertViewController *)createCustomAlertViewWithActionCount:(NSInteger)actionCount {
    NSMutableArray<NYAlertAction *> *mutableActions = [NSMutableArray array];

    for (NSInteger i = 0; i < actionCount; i++) {
        NSString *actionTitle = [NSString stringWithFormat:@"Action %ld", i + 1];
        UIAlertActionStyle actionStyle = UIAlertActionStyleDefault;

        // Set up the final action as a cancel button
        if (i == actionCount - 1) {
            actionTitle = @"Cancel";
            actionStyle = UIAlertActionStyleCancel;
        }

        [mutableActions addObject:[NYAlertAction actionWithTitle:actionTitle style:actionStyle handler:nil]];
    }

    NYAlertViewControllerConfiguration *configuration = [NYAlertViewControllerConfiguration new];
    configuration.transitionStyle = NYAlertViewControllerTransitionStyleFade;
    configuration.backgroundTapDismissalGestureEnabled = YES;
    configuration.swipeDismissalGestureEnabled = YES;
    configuration.alwaysArrangesActionButtonsVertically = YES;

    NSString *title = @"Example Title";
    NSString *message = @"This alert uses the fade transition style! Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Donec id elit non mi porta gravida at eget metus.";

    return [[NYAlertViewController alloc] initWithOptions:configuration
                                                    title:title
                                                  message:message
                                                  actions:[NSArray arrayWithArray:mutableActions]];
}

- (NYAlertViewController *)createTextFieldAlertView {
    NSString *title = @"Login";
    NSString *message = @"The submit action is disabled until text is entered in both text fields";

    NYAlertAction *submitAction = [NYAlertAction actionWithTitle:@"Submit"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
    submitAction.enabled = NO;

    NYAlertAction *cancelAction = [NYAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
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

    return alertViewController;
}

- (NYAlertViewController *)createMapViewAlertView {
    NSString *title = @"Content View";
    NSString *message = @"Set the alertViewContentView property to add custom views to the alert view";
    NYAlertAction *deleteAction = [NYAlertAction actionWithTitle:@"Delete"
                                                           style:UIAlertActionStyleDestructive
                                                         handler:nil];
    NYAlertAction *cancelAction = [NYAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithOptions:nil
                                                                                          title:title
                                                                                        message:message
                                                                                        actions:@[deleteAction, cancelAction]];


    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectZero];
    mapView.translatesAutoresizingMaskIntoConstraints = NO;
    mapView.zoomEnabled = NO;
    mapView.scrollEnabled = NO;
    [mapView.heightAnchor constraintEqualToConstant:160.0f].active = YES;

    CLLocationCoordinate2D infiniteLoopCoordinate = CLLocationCoordinate2DMake(37.331693, -122.030457);
    mapView.region = MKCoordinateRegionMakeWithDistance(infiniteLoopCoordinate, 1000.0f, 1000.0f);
    alertViewController.alertViewContentView = mapView;

    return alertViewController;
}

- (NYAlertViewController *)createLongMessageAlertView {
    NYAlertViewControllerConfiguration *configuration = [NYAlertViewControllerConfiguration new];
    configuration.transitionStyle = NYAlertViewControllerTransitionStyleSlideFromBottom;
    NSString *title = @"Terms and Conditions";
    NSString *message = @"This alert view uses the slide from bottom transition style!\n\nNullam id dolor id nibh ultricies vehicula ut id elit. Donec id elit non mi porta gravida at eget metus. Maecenas faucibus mollis interdum. Donec id elit non mi porta gravida at eget metus. Aenean lacinia bibendum nulla sed consectetur. Nullam id dolor id nibh ultricies vehicula ut id elit. Donec ullamcorper nulla non metus auctor fringilla. Nulla vitae elit libero, a pharetra augue. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Nullam id dolor id nibh ultricies vehicula ut id elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Donec id elit non mi porta gravida at eget metus. Etiam porta sem malesuada magna mollis euismod. Curabitur blandit tempus porttitor. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Donec ullamcorper nulla non metus auctor fringilla. Nullam quis risus eget urna mollis ornare vel eu leo. Etiam porta sem malesuada magna mollis euismod. Maecenas faucibus mollis interdum. Maecenas sed diam eget risus varius blandit sit amet non magna.";

    NYAlertAction *acceptAction = [NYAlertAction actionWithTitle:@"Accept"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];

    NYAlertAction *declineAction = [NYAlertAction actionWithTitle:@"Decline"
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil];

    return [[NYAlertViewController alloc] initWithOptions:configuration
                                                    title:title
                                                  message:message
                                                  actions:@[acceptAction, declineAction]];
}

- (NYAlertViewController *)createCustomFontAlertView {
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

    NSString *title = @"Custom Fonts";
    NSString *message = @"Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Donec id elit non mi porta gravida at eget metus.";
    NYAlertAction *okAction = [NYAlertAction actionWithTitle:@"Subscribe"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    NYAlertAction *cancelAction = [NYAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    return [[NYAlertViewController alloc] initWithOptions:configuration
                                                    title:title
                                                  message:message
                                                  actions:@[okAction, cancelAction]];
}

#pragma mark - UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Alert View Examples";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.demoItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text = self.demoItems[indexPath.row].title;

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self presentViewController:self.demoItems[indexPath.row].alertViewController
                       animated:YES
                     completion:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
