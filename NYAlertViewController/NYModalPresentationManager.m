//
//  NYModalPresentationManager.m
//
//  Created by Nealon Young on 6/21/15.
//  Copyright (c) 2015 Nealon Young. All rights reserved.
//

#import "NYModalPresentationManager.h"

#import "NYModalDismissalAnimationController.h"
#import "NYModalPresentationAnimationController.h"
#import "NYModalPresentationController.h"

@implementation NYModalPresentationManager

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                      presentingViewController:(UIViewController *)presenting
                                                          sourceViewController:(UIViewController *)source {
    return [[NYModalPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source {
    return [[NYModalPresentationAnimationController alloc] init];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    NYModalDismissalAnimationController *animationController = [[NYModalDismissalAnimationController alloc] init];
    return animationController;
}

@end
