//
//  NYAlertViewPresentationAnimationController.h
//  NYAlertViewDemo
//
//  Created by Guillermo Saenz on 6/14/16.
//  Copyright © 2016 Nealon Young. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NYAlertViewController.h"

@interface NYAlertViewPresentationAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property NYAlertViewControllerTransitionStyle transitionStyle;
@property CGFloat duration;

@end
