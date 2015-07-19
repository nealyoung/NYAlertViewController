//
//  NYModalPresentationAnimationController.m
//
//  Created by Nealon Young on 6/21/15.
//  Copyright (c) 2015 Nealon Young. All rights reserved.
//

#import "NYModalPresentationAnimationController.h"

static CGFloat const kDefaultDuration = 0.7f;

@implementation NYModalPresentationAnimationController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.duration = kDefaultDuration;
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
