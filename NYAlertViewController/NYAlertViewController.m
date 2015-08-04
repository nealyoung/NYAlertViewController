//
//  NYAlertViewController.m
//
//  Created by Nealon Young on 7/13/15.
//  Copyright (c) 2015 Nealon Young. All rights reserved.
//

#import "NYAlertViewController.h"

#import "NYAlertView.h"

@implementation NYAlertAction

+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(NYAlertAction *action))handler {
    NYAlertAction *action = [[NYAlertAction alloc] init];
    action.title = title;
    action.style = style;
    action.handler = handler;
    
    return action;
}
@end

@interface NYAlertViewPresentationAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property CGFloat duration;

@end

static CGFloat const kDefaultPresentationAnimationDuration = 0.7f;

@implementation NYAlertViewPresentationAnimationController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.duration = kDefaultPresentationAnimationDuration;
    }
    
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect initialFrame = [transitionContext finalFrameForViewController:toViewController];
    
    initialFrame.origin.y = -(initialFrame.size.height + initialFrame.origin.y);
    toViewController.view.frame = initialFrame;
    
    [[transitionContext containerView] addSubview:toViewController.view];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0f / 600.0f;
    transform = CATransform3DRotate(transform, M_PI_4 * 1.3f, 1.0f, 0.0f, 0.0f);
    
    toViewController.view.layer.zPosition = 100.0f;
    toViewController.view.layer.transform = transform;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0f
         usingSpringWithDamping:0.76f
          initialSpringVelocity:0.2f
                        options:0
                     animations:^{
                         toViewController.view.layer.transform = CATransform3DIdentity;
                         toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

@end

@interface NYAlertViewDismissalAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property CGFloat duration;

@end

static CGFloat const kDefaultDismissalAnimationDuration = 0.6f;

@implementation NYAlertViewDismissalAnimationController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.duration = kDefaultDismissalAnimationDuration;
    }
    
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:fromViewController];
    
    finalFrame.origin.y = 1.2f * CGRectGetHeight([transitionContext containerView].frame);
    //    [toViewController.view layoutIfNeeded];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0f
         usingSpringWithDamping:0.8f
          initialSpringVelocity:0.1f
                        options:0
                     animations:^{
                         fromViewController.view.frame = finalFrame;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

@end

@interface NYAlertViewPresentationController : UIPresentationController

@property CGFloat presentedViewControllerHorizontalInset;
@property CGFloat presentedViewControllerVerticalInset;
@property (nonatomic) BOOL backgroundTapDismissalGestureEnabled;

@end

@interface NYAlertViewPresentationController ()

@property UIView *backgroundDimmingView;

- (void)tapGestureRecognized:(UITapGestureRecognizer *)gestureRecognizer;

@end

@implementation NYAlertViewPresentationController

- (void)presentationTransitionWillBegin {
    self.presentedViewController.view.layer.cornerRadius = 6.0f;
    self.presentedViewController.view.layer.masksToBounds = YES;
    
    self.backgroundDimmingView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.backgroundDimmingView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.backgroundDimmingView.alpha = 0.0f;
    self.backgroundDimmingView.backgroundColor = [UIColor blackColor];
    [self.containerView addSubview:self.backgroundDimmingView];
    
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_backgroundDimmingView]|"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:NSDictionaryOfVariableBindings(_backgroundDimmingView)]];
    
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_backgroundDimmingView]|"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:NSDictionaryOfVariableBindings(_backgroundDimmingView)]];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognized:)];
    [self.backgroundDimmingView addGestureRecognizer:tapGestureRecognizer];
    
    // Shrink the presenting view controller, and animate in the dark background view
    id <UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.backgroundDimmingView.alpha = 0.7f;
    }
                                           completion:nil];
}

- (BOOL)shouldPresentInFullscreen {
    return NO;
}

- (BOOL)shouldRemovePresentersView {
    return NO;
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    [super presentationTransitionDidEnd:completed];
    
    if (!completed) {
        [self.backgroundDimmingView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin {
    [super dismissalTransitionWillBegin];
    
    id <UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.backgroundDimmingView.alpha = 0.0f;
        
        self.presentingViewController.view.transform = CGAffineTransformIdentity;
    }
                                           completion:nil];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)containerViewWillLayoutSubviews {
    [super containerViewWillLayoutSubviews];
    
    [self presentedView].frame = [self frameOfPresentedViewInContainerView];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    [super dismissalTransitionDidEnd:completed];
    
    if (completed) {
        [self.backgroundDimmingView removeFromSuperview];
    }
}

- (void)tapGestureRecognized:(UITapGestureRecognizer *)gestureRecognizer {
    if (self.backgroundTapDismissalGestureEnabled) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

@end

@interface NYAlertViewController () <UIGestureRecognizerDelegate, UIViewControllerTransitioningDelegate>

@property NYAlertView *view;
@property UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) id<UIViewControllerTransitioningDelegate> transitioningDelegate;

- (void)panGestureRecognized:(UIPanGestureRecognizer *)gestureRecognizer;

@end

@implementation NYAlertViewController

@dynamic view;

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

- (void)commonInit {
    _actions = [NSArray array];
    
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self;
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    panGestureRecognizer.delegate = self;
    panGestureRecognizer.enabled = self.swipeDismissalGestureEnabled;
    [self.view addGestureRecognizer:panGestureRecognizer];
}

- (void)loadView {
    self.view = [[NYAlertView alloc] initWithFrame:CGRectZero];
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
                                 [self.view layoutIfNeeded];
                             }
                             completion:nil];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.view.actions = self.actions;
}

- (void)setAlertViewBackgroundColor:(UIColor *)alertViewBackgroundColor {
    _alertViewBackgroundColor = alertViewBackgroundColor;
    
    self.view.alertBackgroundView.backgroundColor = alertViewBackgroundColor;
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

- (UIFont *)buttonTitleFont {
    return self.view.buttonTitleFont;
}

- (void)setButtonTitleFont:(UIFont *)buttonTitleFont {
    self.view.buttonTitleFont = buttonTitleFont;
}

- (UIFont *)cancelButtonTitleFont {
    return self.view.cancelButtonTitleFont;
}

- (void)setCancelButtonTitleFont:(UIFont *)cancelButtonTitleFont {
    self.view.cancelButtonTitleFont = cancelButtonTitleFont;
}

- (UIFont *)destructiveButtonTitleFont {
    return self.view.destructiveButtonTitleFont;
}

- (void)setDestructiveButtonTitleFont:(UIFont *)destructiveButtonTitleFont {
    self.view.destructiveButtonTitleFont = destructiveButtonTitleFont;
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

- (UIColor *)buttonColor {
    return self.view.buttonColor;
}

- (void)setButtonColor:(UIColor *)buttonColor {
    self.view.buttonColor = buttonColor;
}

- (UIColor *)cancelButtonColor {
    return self.view.cancelButtonColor;
}

- (void)setCancelButtonColor:(UIColor *)cancelButtonColor {
    self.view.cancelButtonColor = cancelButtonColor;
}

- (UIColor *)destructiveButtonColor {
    return self.view.destructiveButtonColor;
}

- (void)setDestructiveButtonColor:(UIColor *)destructiveButtonColor {
    self.view.destructiveButtonColor = destructiveButtonColor;
}

- (UIColor *)buttonTitleColor {
    return self.view.buttonTitleColor;
}

- (void)setButtonTitleColor:(UIColor *)buttonTitleColor {
    self.view.buttonTitleColor = buttonTitleColor;
}

- (UIColor *)cancelButtonTitleColor {
    return self.view.cancelButtonTitleColor;
}

- (void)setCancelButtonTitleColor:(UIColor *)cancelButtonTitleColor {
    self.view.cancelButtonTitleColor = cancelButtonTitleColor;
}

- (UIColor *)destructiveButtonTitleColor {
    return self.view.destructiveButtonTitleColor;
}

- (void)setDestructiveButtonTitleColor:(UIColor *)destructiveButtonTitleColor {
    self.view.destructiveButtonTitleColor = destructiveButtonTitleColor;
}

- (CGFloat)alertViewCornerRadius {
    return self.view.alertBackgroundView.layer.cornerRadius;
}

- (void)setAlertViewCornerRadius:(CGFloat)alertViewCornerRadius {
    self.view.alertBackgroundView.layer.cornerRadius = alertViewCornerRadius;
}

- (CGFloat)buttonCornerRadius {
    return self.view.buttonCornerRadius;
}

- (void)setButtonCornerRadius:(CGFloat)buttonCornerRadius {
    self.view.buttonCornerRadius = buttonCornerRadius;
}

- (void)addAction:(UIAlertAction *)action {
    _actions = [self.actions arrayByAddingObject:action];
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
    return [[NYAlertViewPresentationAnimationController alloc] init];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    NYAlertViewDismissalAnimationController *animationController = [[NYAlertViewDismissalAnimationController alloc] init];
    return animationController;
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
