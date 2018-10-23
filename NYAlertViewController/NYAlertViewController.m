#import "NYAlertViewController.h"

#import "NYAlertView.h"
#import "NYAlertAction+Private.h"
#import "NYAlertViewButton.h"
#import "NYAlertViewDismissalAnimationController.h"
#import "NYAlertViewPresentationAnimationController.h"
#import "NYAlertViewPresentationController.h"

@interface NYAlertViewController () <UIGestureRecognizerDelegate, UIViewControllerTransitioningDelegate>

@property NYAlertView *view;
@property UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) id<UIViewControllerTransitioningDelegate> transitioningDelegate;

- (void)panGestureRecognized:(UIPanGestureRecognizer *)gestureRecognizer;

@end

@implementation NYAlertViewController

@dynamic view;

- (instancetype)initWithOptions:(NYAlertViewControllerConfiguration *)configuration
                          title:(NSString *)title
                        message:(NSString *)message
                        actions:(NSArray<NYAlertAction *> *)actions {
    self = [super initWithNibName:nil bundle:nil];

    if (self) {
        _configuration = [configuration copy] ?: [NYAlertViewControllerConfiguration new];
        _actions = actions;
        _textFields = [NSArray array];

        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;

        self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
        self.panGestureRecognizer.delegate = self;
        self.panGestureRecognizer.enabled = configuration.swipeDismissalGestureEnabled;
        [self.view addGestureRecognizer:self.panGestureRecognizer];

        [self setTitle:title];
        [self setMessage:message];
    }

    return self;
}

- (void)viewDidDisappear:(BOOL)animated {
    // Necessary to avoid retain cycle - http://stackoverflow.com/a/21218703/1227862
//    self.transitioningDelegate = nil;
    [super viewDidDisappear:animated];
}

- (void)loadView {
    self.view = [[NYAlertView alloc] initWithConfiguration:self.configuration];
}

- (BOOL)prefersStatusBarHidden {
    return !self.configuration.showsStatusBar;
}

- (CGFloat)maximumWidth {
    return self.view.maximumWidth;
}

- (void)setMaximumWidth:(CGFloat)maximumWidth {
    self.view.maximumWidth = maximumWidth;
}

- (UIView *)alertViewContentView {
    return self.view.contentView;
}

- (void)setAlertViewContentView:(UIView *)alertViewContentView {
    self.view.contentView = alertViewContentView;
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)gestureRecognizer {
    self.view.backgroundViewVerticalCenteringConstraint.constant = [gestureRecognizer translationInView:self.view].y;
    
    NYAlertViewPresentationController *presentationController = (NYAlertViewPresentationController *)self.presentationController;
    
    CGFloat windowHeight = CGRectGetHeight([UIApplication sharedApplication].keyWindow.bounds);
    presentationController.backgroundDimmingView.alpha = 0.7f - (fabs([gestureRecognizer translationInView:self.view].y) / windowHeight);
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGFloat verticalGestureVelocity = [gestureRecognizer velocityInView:self.view].y;
        
        // If the gesture is moving fast enough, animate the alert view offscreen and dismiss the view controller. Otherwise, animate the alert view back to its initial position
        if (fabs(verticalGestureVelocity) > 500.0f) {
            CGFloat backgroundViewYPosition;
            
            if (verticalGestureVelocity > 500.0f) {
                backgroundViewYPosition = CGRectGetHeight(self.view.frame);
            } else {
                backgroundViewYPosition = -CGRectGetHeight(self.view.frame);
            }
            
            CGFloat animationDuration = 500.0f / fabs(verticalGestureVelocity);
            
            self.view.backgroundViewVerticalCenteringConstraint.constant = backgroundViewYPosition;
            [UIView animateWithDuration:animationDuration
                                  delay:0.0f
                 usingSpringWithDamping:0.8f
                  initialSpringVelocity:0.2f
                                options:0
                             animations:^{
                                 presentationController.backgroundDimmingView.alpha = 0.0f;
                                 [self.view layoutIfNeeded];
                             }
                             completion:^(BOOL finished) {
                                 [self dismissViewControllerAnimated:YES completion:^{
                                     self.view.backgroundViewVerticalCenteringConstraint.constant = 0.0f;
                                 }];
                             }];
        } else {
            self.view.backgroundViewVerticalCenteringConstraint.constant = 0.0f;
            [UIView animateWithDuration:0.5f
                                  delay:0.0f
                 usingSpringWithDamping:0.8f
                  initialSpringVelocity:0.4f
                                options:0
                             animations:^{
                                 presentationController.backgroundDimmingView.alpha = 0.7f;
                                 [self.view layoutIfNeeded];
                             }
                             completion:nil];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self createActionButtons];
    self.view.textFields = self.textFields;
}

- (void)createActionButtons {
    NSMutableArray *buttons = [NSMutableArray array];
    
    // Create buttons for each action
    for (int i = 0; i < [self.actions count]; i++) {
        NYAlertAction *action = self.actions[i];
        
        NYAlertViewButton *button = [NYAlertViewButton buttonWithType:UIButtonTypeCustom];

        button.tag = i;
        [button addTarget:self action:@selector(actionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        button.enabled = action.enabled;
        
        [button setTranslatesAutoresizingMaskIntoConstraints:NO];
        [button setTitle:action.title forState:UIControlStateNormal];

        NYAlertActionConfiguration *buttonConfiguration;
        if (action.configuration) {
            buttonConfiguration = action.configuration;
        } else {
            switch (action.style) {
                case UIAlertActionStyleDefault:
                    buttonConfiguration = self.configuration.buttonConfiguration;
                    break;
                case UIAlertActionStyleCancel:
                    buttonConfiguration = self.configuration.cancelButtonConfiguration;
                    break;
                case UIAlertActionStyleDestructive:
                    buttonConfiguration = self.configuration.destructiveButtonConfiguration;
                    break;
            }
        }
        
        [button setTitleColor:buttonConfiguration.disabledTitleColor forState:UIControlStateDisabled];
        [button setTitleColor:buttonConfiguration.titleColor forState:UIControlStateNormal];
        [button setTitleColor:buttonConfiguration.titleColor forState:UIControlStateHighlighted];
        button.titleLabel.font = buttonConfiguration.titleFont;

        [buttons addObject:button];
        action.actionButton = button;
    }
    
    self.view.actionButtons = buttons;
}

- (void)actionButtonPressed:(UIButton *)button {
    NYAlertAction *action = self.actions[button.tag];

    if (action.handler) {
        action.handler(action);
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Getters/Setters

- (void)setTitle:(NSString *)title {
    [super setTitle:title];

    self.view.titleLabel.text = title;
}

- (void)setMessage:(NSString *)message {
    _message = message;
    self.view.messageTextView.text = message;
}

- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.borderStyle = UITextBorderStyleRoundedRect;

    if (configurationHandler) {
        configurationHandler(textField);
    }

    _textFields = [self.textFields arrayByAddingObject:textField];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                      presentingViewController:(UIViewController *)presenting
                                                          sourceViewController:(UIViewController *)source {
    NYAlertViewPresentationController *presentationController = [[NYAlertViewPresentationController alloc] initWithPresentedViewController:presented
                                                                                                                  presentingViewController:presenting];
    presentationController.backgroundTapDismissalGestureEnabled = self.configuration.backgroundTapDismissalGestureEnabled;
    return presentationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source {
    NYAlertViewPresentationAnimationController *presentationAnimationController = [[NYAlertViewPresentationAnimationController alloc] init];
    presentationAnimationController.transitionStyle = self.configuration.transitionStyle;
    return presentationAnimationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    NYAlertViewDismissalAnimationController *dismissalAnimationController = [[NYAlertViewDismissalAnimationController alloc] init];
    dismissalAnimationController.transitionStyle = self.configuration.transitionStyle;
    return dismissalAnimationController;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // Don't recognize the pan gesture in the button, so users can move their finger away after touching down
    if (([touch.view isKindOfClass:[UIButton class]])) {
        return NO;
    }
    
    return YES;
}

@end
