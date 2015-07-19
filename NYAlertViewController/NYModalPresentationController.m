//
//  NYModalPresentationController.m
//
//  Created by Nealon Young on 5/8/15.
//  Copyright (c) 2015 Nealon Young. All rights reserved.
//

#import "NYModalPresentationController.h"

@interface NYModalPresentationController ()

@property UIView *backgroundDimmingView;

- (void)tapGestureRecognized:(UITapGestureRecognizer *)gestureRecognizer;

@end

static const CGFloat kDefaultHorizontalInset = 10.0f;
static const CGFloat kDefaultVerticalInset = 12.0f;

@implementation NYModalPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    
    if (self) {
        self.presentedViewControllerHorizontalInset = kDefaultHorizontalInset;
        self.presentedViewControllerVerticalInset = kDefaultVerticalInset;
        //        [self.containerView addSubview:self.backgroundDimmingView];
    }
    
    return self;
}

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
        
        //        self.presentingViewController.view.transform = CGAffineTransformMakeScale(0.8f, 0.8f);
    }
                                           completion:nil];
    
    //    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (BOOL)shouldPresentInFullscreen {
    return NO;
}

- (BOOL)shouldRemovePresentersView {
    return NO;
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
        [self.backgroundDimmingView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin {
    id <UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.backgroundDimmingView.alpha = 0.0f;
        
        self.presentingViewController.view.transform = CGAffineTransformIdentity;
    }
                                           completion:nil];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)containerViewWillLayoutSubviews {
    self.presentedView.frame = CGRectInset(self.containerView.bounds, 18.0f, 24.0f);
    
    NSLog(@"%@", NSStringFromCGSize(self.containerView.frame.size));
    NSLog(@"Will Layout Container Subviews");
}

- (void)containerViewDidLayoutSubviews {
    NSLog(@"%@", NSStringFromCGSize(self.containerView.frame.size));
    NSLog(@"Did Layout Container Subviews");
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        [self.backgroundDimmingView removeFromSuperview];
    }
}

- (CGRect)frameOfPresentedViewInContainerView {
    return CGRectInset(self.containerView.bounds, 18.0f, 24.0f);
}

- (void)tapGestureRecognized:(UITapGestureRecognizer *)gestureRecognizer {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
