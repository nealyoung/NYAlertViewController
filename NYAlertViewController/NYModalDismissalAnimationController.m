//
//  NYModalDismissalAnimationController.m
//
//  Created by Nealon Young on 6/21/15.
//  Copyright (c) 2015 Nealon Young. All rights reserved.
//

#import "NYModalDismissalAnimationController.h"

static CGFloat const kDefaultDuration = 0.6f;

@implementation NYModalDismissalAnimationController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.duration = kDefaultDuration;
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