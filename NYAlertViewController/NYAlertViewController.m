//
//  NYAlertViewController.m
//
//  Created by Nealon Young on 7/13/15.
//  Copyright (c) 2015 Nealon Young. All rights reserved.
//

#import "NYAlertViewController.h"

#import "NYAlertView.h"
#import "NYModalPresentationManager.h"
#import "NYRoundRectButton.h"

@interface NYAlertViewController () <UIGestureRecognizerDelegate>

@property NYAlertView *view;
@property (nonatomic, strong) id<UIViewControllerTransitioningDelegate> transitioningDelegate;

- (void)panGestureRecognized:(UIPanGestureRecognizer *)gestureRecognizer;

@end

@implementation NYAlertViewController

@dynamic view;

- (void)loadView {
    self.view = [[NYAlertView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _actions = [NSArray array];
    
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = [[NYModalPresentationManager alloc] init];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    panGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:panGestureRecognizer];
}

- (UIView *)alertViewContentView {
    return self.view.contentView;
}

- (void)setAlertViewContentView:(UIView *)alertViewContentView {
    self.view.contentView = alertViewContentView;
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

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    
    self.view.titleLabel.text = title;
}

- (void)setMessage:(NSString *)message {
    _message = message;
    self.view.messageLabel.text = message;
}

- (UIFont *)titleFont {
    return self.view.titleFont;
}

- (void)setTitleFont:(UIFont *)titleFont {
    self.view.titleFont = titleFont;
}

- (UIFont *)messageFont {
    return self.view.messageFont;
}

- (void)setMessageFont:(UIFont *)messageFont {
    self.view.messageFont = messageFont;
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

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // Don't recognize the pan gesture in the button, so users can move their finger away after touch down
    if (([touch.view isKindOfClass:[UIButton class]])) {
        return NO;
    }
    return YES;
}

@end
