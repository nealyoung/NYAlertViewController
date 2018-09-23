#import "NYAlertViewDismissalAnimationController.h"

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
    if (self.transitionStyle == NYAlertViewControllerTransitionStyleSlideFromTop || self.transitionStyle == NYAlertViewControllerTransitionStyleSlideFromBottom) {
        UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

        CGRect finalFrame = [transitionContext finalFrameForViewController:fromViewController];
        finalFrame.origin.y = 1.2f * CGRectGetHeight([transitionContext containerView].frame);

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
    } else {
        UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                             fromViewController.view.layer.opacity = 0.0f;
                         }
                         completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (self.transitionStyle) {
        case NYAlertViewControllerTransitionStyleFade:
            return 0.3f;
            break;

        case NYAlertViewControllerTransitionStyleSlideFromTop:
        case NYAlertViewControllerTransitionStyleSlideFromBottom:
            return 0.6f;
    }}

@end
