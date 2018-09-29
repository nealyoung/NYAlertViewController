#import "NYAlertViewPresentationController.h"
#import "UIView+Additions.h"

@interface NYAlertViewPresentationController ()

- (void)tapGestureRecognized:(UITapGestureRecognizer *)gestureRecognizer;

@end

@implementation NYAlertViewPresentationController

- (void)presentationTransitionWillBegin {
    self.presentedViewController.view.layer.cornerRadius = 6.0f;
    self.presentedViewController.view.layer.masksToBounds = YES;

    self.backgroundDimmingView = [[UIView alloc] initWithFrame:CGRectZero];
    self.backgroundDimmingView.alpha = 0.0f;
    self.backgroundDimmingView.backgroundColor = [UIColor blackColor];
    [self.containerView addSubview:self.backgroundDimmingView];

    [self.backgroundDimmingView ny_pinEdgesToSuperviewEdges];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognized:)];
    [self.backgroundDimmingView addGestureRecognizer:tapGestureRecognizer];

    // Shrink the presenting view controller, and animate in the dark background view
    id <UIViewControllerTransitionCoordinator> transitionCoordinator = [self.presentingViewController transitionCoordinator];
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.backgroundDimmingView.alpha = 0.7f;
    } completion:nil];
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

    id <UIViewControllerTransitionCoordinator> transitionCoordinator = [self.presentingViewController transitionCoordinator];
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.backgroundDimmingView.alpha = 0.0f;

        self.presentingViewController.view.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)containerViewWillLayoutSubviews {
    [super containerViewWillLayoutSubviews];

    [self presentedView].frame = [self frameOfPresentedViewInContainerView];
    self.backgroundDimmingView.frame = self.containerView.bounds;
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
