//
//  NYAlertViewPresentationController.h
//  NYAlertViewDemo
//
//  Created by Guillermo Saenz on 6/14/16.
//  Copyright © 2016 Nealon Young. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NYAlertViewPresentationController : UIPresentationController

@property CGFloat presentedViewControllerHorizontalInset;
@property CGFloat presentedViewControllerVerticalInset;
@property (nonatomic) BOOL backgroundTapDismissalGestureEnabled;
@property UIView *backgroundDimmingView;

@property UIColor *backgroundDimmingViewColor;
@property CGFloat backgroundDimmingViewFinalAlpha;

@end
