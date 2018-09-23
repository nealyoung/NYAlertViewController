#import "NYAlertViewController.h"

#import "NYAlertView.h"
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

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message {
    NYAlertViewController *alertController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    alertController.title = title;
    alertController.message = message;
    
    return alertController;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)viewDidDisappear:(BOOL)animated {
    // Necessary to avoid retain cycle - http://stackoverflow.com/a/21218703/1227862
    self.transitioningDelegate = nil;
    [super viewDidDisappear:animated];
}

- (void)commonInit {
    _actions = [NSArray array];
    _textFields = [NSArray array];
    
    _showsStatusBar = YES;
    
    _buttonTitleFont = [UIFont systemFontOfSize:16.0f];
    _cancelButtonTitleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    _destructiveButtonTitleFont = [UIFont systemFontOfSize:16.0f];
    
    _buttonColor = [UIColor darkGrayColor];
    _buttonTitleColor = [UIColor whiteColor];
    _cancelButtonColor = [UIColor darkGrayColor];
    _cancelButtonTitleColor = [UIColor whiteColor];
    _destructiveButtonColor = [UIColor colorWithRed:1.0f green:0.23f blue:0.21f alpha:1.0f];
    _destructiveButtonTitleColor = [UIColor whiteColor];
    _disabledButtonColor = [UIColor lightGrayColor];
    _disabledButtonTitleColor = [UIColor whiteColor];
    
    _buttonCornerRadius = 6.0f;
    
    _transitionStyle = NYAlertViewControllerTransitionStyleSlideFromTop;
    
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self;
    
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    self.panGestureRecognizer.delegate = self;
    self.panGestureRecognizer.enabled = NO;
    [self.view addGestureRecognizer:self.panGestureRecognizer];
}

- (void)loadView {
    self.view = [[NYAlertView alloc] initWithFrame:CGRectZero];
}

- (BOOL)prefersStatusBarHidden {
    return !self.showsStatusBar;
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

- (void)setSwipeDismissalGestureEnabled:(BOOL)swipeDismissalGestureEnabled {
    _swipeDismissalGestureEnabled = swipeDismissalGestureEnabled;
    
    self.panGestureRecognizer.enabled = swipeDismissalGestureEnabled;
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)gestureRecognizer {
    self.view.backgroundViewVerticalCenteringConstraint.constant = [gestureRecognizer translationInView:self.view].y;
    
    NYAlertViewPresentationController *presentationController = (NYAlertViewPresentationController* )self.presentationController;
    
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
                                 [self dismissViewControllerAnimated:YES completion:nil];
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

- (void)setAlertViewBackgroundColor:(UIColor *)alertViewBackgroundColor {
    _alertViewBackgroundColor = alertViewBackgroundColor;
    
    self.view.alertBackgroundView.backgroundColor = alertViewBackgroundColor;
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
        
        button.cornerRadius = self.buttonCornerRadius;
        [button setTranslatesAutoresizingMaskIntoConstraints:NO];
        [button setTitle:action.title forState:UIControlStateNormal];
        
        [button setTitleColor:self.disabledButtonTitleColor forState:UIControlStateDisabled];
        [button setBackgroundColor:self.disabledButtonColor forState:UIControlStateDisabled];


        switch (action.style) {
            case UIAlertActionStyleDefault:
                [button setTitleColor:self.buttonTitleColor forState:UIControlStateNormal];
                [button setTitleColor:self.buttonTitleColor forState:UIControlStateHighlighted];
                [button setBackgroundColor:self.buttonColor forState:UIControlStateNormal];

                button.titleLabel.font = self.buttonTitleFont;
                break;
            case UIAlertActionStyleCancel:
                [button setTitleColor:self.cancelButtonTitleColor forState:UIControlStateNormal];
                [button setTitleColor:self.cancelButtonTitleColor forState:UIControlStateHighlighted];
                [button setBackgroundColor:self.cancelButtonColor forState:UIControlStateNormal];

                button.titleLabel.font = self.cancelButtonTitleFont;
                break;
            case UIAlertActionStyleDestructive:
                [button setTitleColor:self.destructiveButtonTitleColor forState:UIControlStateNormal];
                [button setTitleColor:self.destructiveButtonTitleColor forState:UIControlStateHighlighted];
                [button setBackgroundColor:self.destructiveButtonColor forState:UIControlStateNormal];

                button.titleLabel.font = self.destructiveButtonTitleFont;
                break;
        }

        [buttons addObject:button];        
        action.actionButton = button;
    }
    
    self.view.actionButtons = buttons;
}

- (void)actionButtonPressed:(UIButton *)button {
    NYAlertAction *action = self.actions[button.tag];
    action.handler(action);
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

- (UIFont *)titleFont {
    return self.view.titleLabel.font;
}

- (void)setTitleFont:(UIFont *)titleFont {
    self.view.titleLabel.font = titleFont;
}

- (UIFont *)messageFont {
    return self.view.messageTextView.font;
}

- (void)setMessageFont:(UIFont *)messageFont {
    self.view.messageTextView.font = messageFont;
}

- (void)setButtonTitleFont:(UIFont *)buttonTitleFont {
    _buttonTitleFont = buttonTitleFont;
    
    [self.view.actionButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        NYAlertAction *action = self.actions[idx];
        
        if (action.style != UIAlertActionStyleCancel) {
            button.titleLabel.font = buttonTitleFont;
        }
    }];
}

- (void)setCancelButtonTitleFont:(UIFont *)cancelButtonTitleFont {
    _cancelButtonTitleFont = cancelButtonTitleFont;
    
    [self.view.actionButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        NYAlertAction *action = self.actions[idx];
        
        if (action.style == UIAlertActionStyleCancel) {
            button.titleLabel.font = cancelButtonTitleFont;
        }
    }];
}

- (void)setDestructiveButtonTitleFont:(UIFont *)destructiveButtonTitleFont {
    _destructiveButtonTitleFont = destructiveButtonTitleFont;
    
    [self.view.actionButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        NYAlertAction *action = self.actions[idx];
        
        if (action.style == UIAlertActionStyleDestructive) {
            button.titleLabel.font = destructiveButtonTitleFont;
        }
    }];
}

- (UIColor *)titleColor {
    return self.view.titleLabel.textColor;
}

- (void)setTitleColor:(UIColor *)titleColor {
    self.view.titleLabel.textColor = titleColor;
}

- (UIColor *)messageColor {
    return self.view.messageTextView.textColor;
}

- (void)setMessageColor:(UIColor *)messageColor {
    self.view.messageTextView.textColor = messageColor;
}

- (void)setButtonColor:(UIColor *)buttonColor {
    _buttonColor = buttonColor;
    
    [self.view.actionButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        NYAlertAction *action = self.actions[idx];
        
        if (action.style != UIAlertActionStyleCancel) {
            [button setBackgroundColor:buttonColor forState:UIControlStateNormal];
        }
    }];
}

- (void)setCancelButtonColor:(UIColor *)cancelButtonColor {
    _cancelButtonColor = cancelButtonColor;
    
    [self.view.actionButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        NYAlertAction *action = self.actions[idx];
        
        if (action.style == UIAlertActionStyleCancel) {
            [button setBackgroundColor:cancelButtonColor forState:UIControlStateNormal];
        }
    }];
}

- (void)setDestructiveButtonColor:(UIColor *)destructiveButtonColor {
    _destructiveButtonColor = destructiveButtonColor;
    
    [self.view.actionButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        NYAlertAction *action = self.actions[idx];
        
        if (action.style == UIAlertActionStyleDestructive) {
            [button setBackgroundColor:destructiveButtonColor forState:UIControlStateNormal];
        }
    }];
}

- (void)setDisabledButtonColor:(UIColor *)disabledButtonColor {
    _disabledButtonColor = disabledButtonColor;
    
    [self.view.actionButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        NYAlertAction *action = self.actions[idx];
        
        if (!action.enabled) {
            [button setBackgroundColor:disabledButtonColor forState:UIControlStateNormal];
        }
    }];
}

- (void)setButtonTitleColor:(UIColor *)buttonTitleColor {
    _buttonTitleColor = buttonTitleColor;
    
    [self.view.actionButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        NYAlertAction *action = self.actions[idx];
        
        if (action.style != UIAlertActionStyleCancel) {
            [button setTitleColor:buttonTitleColor forState:UIControlStateNormal];
            [button setTitleColor:buttonTitleColor forState:UIControlStateHighlighted];
        }
    }];
}

- (void)setCancelButtonTitleColor:(UIColor *)cancelButtonTitleColor {
    _cancelButtonTitleColor = cancelButtonTitleColor;
    
    [self.view.actionButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        NYAlertAction *action = self.actions[idx];
        
        if (action.style == UIAlertActionStyleCancel) {
            [button setTitleColor:cancelButtonTitleColor forState:UIControlStateNormal];
            [button setTitleColor:cancelButtonTitleColor forState:UIControlStateHighlighted];
        }
    }];
}

- (void)setDestructiveButtonTitleColor:(UIColor *)destructiveButtonTitleColor {
    _destructiveButtonTitleColor = destructiveButtonTitleColor;
    
    [self.view.actionButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        NYAlertAction *action = self.actions[idx];
        
        if (action.style == UIAlertActionStyleDestructive) {
            [button setTitleColor:destructiveButtonTitleColor forState:UIControlStateNormal];
            [button setTitleColor:destructiveButtonTitleColor forState:UIControlStateHighlighted];
        }
    }];
}

- (void)setDisabledButtonTitleColor:(UIColor *)disabledButtonTitleColor {
    _disabledButtonTitleColor = disabledButtonTitleColor;
    
    [self.view.actionButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        NYAlertAction *action = self.actions[idx];
        
        if (!action.enabled) {
            [button setTitleColor:disabledButtonTitleColor forState:UIControlStateNormal];
            [button setTitleColor:disabledButtonTitleColor forState:UIControlStateHighlighted];
        }
    }];
}

- (CGFloat)alertViewCornerRadius {
    return self.view.alertBackgroundView.layer.cornerRadius;
}

- (void)setAlertViewCornerRadius:(CGFloat)alertViewCornerRadius {
    self.view.alertBackgroundView.layer.cornerRadius = alertViewCornerRadius;
}

- (void)setButtonCornerRadius:(CGFloat)buttonCornerRadius {
    _buttonCornerRadius = buttonCornerRadius;
    
    for (NYAlertViewButton *button in self.view.actionButtons) {
        button.cornerRadius = buttonCornerRadius;
    }
}

- (void)addAction:(UIAlertAction *)action {
    _actions = [self.actions arrayByAddingObject:action];
}

- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    
    configurationHandler(textField);
    
    _textFields = [self.textFields arrayByAddingObject:textField];
}

- (void)buttonPressed:(UIButton *)sender {
    NYAlertAction *action = self.actions[sender.tag];
    action.handler(action);
}

#pragma mark - UIViewControllerTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                      presentingViewController:(UIViewController *)presenting
                                                          sourceViewController:(UIViewController *)source {
    NYAlertViewPresentationController *presentationController = [[NYAlertViewPresentationController alloc] initWithPresentedViewController:presented
                                                                                                                  presentingViewController:presenting];
    presentationController.backgroundTapDismissalGestureEnabled = self.backgroundTapDismissalGestureEnabled;
    return presentationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source {
    NYAlertViewPresentationAnimationController *presentationAnimationController = [[NYAlertViewPresentationAnimationController alloc] init];
    presentationAnimationController.transitionStyle = self.transitionStyle;
    return presentationAnimationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    NYAlertViewDismissalAnimationController *dismissalAnimationController = [[NYAlertViewDismissalAnimationController alloc] init];
    dismissalAnimationController.transitionStyle = self.transitionStyle;
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
