//
//  NYAlertViewController.h
//
//  Created by Nealon Young on 7/13/15.
//  Copyright (c) 2015 Nealon Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYAlertAction.h"

@interface NYAlertViewController : UIViewController

@property (nonatomic) NSString *message;

@property (nonatomic) UIColor *alertViewBackgroundColor;

@property (nonatomic) UIFont *titleFont;
@property (nonatomic) UIFont *messageFont;
@property (nonatomic) UIFont *buttonTitleFont;
@property (nonatomic) UIFont *cancelButtonTitleFont;

@property (nonatomic) UIColor *titleColor;
@property (nonatomic) UIColor *messageColor;
@property (nonatomic) UIColor *buttonColor;
@property (nonatomic) UIColor *cancelButtonColor;

@property (nonatomic) CGFloat alertViewCornerRadius;
@property (nonatomic) CGFloat buttonCornerRadius;

@property (nonatomic, readonly) NSArray *actions;
@property (nonatomic) UIView *alertViewContentView;

- (void)addAction:(NYAlertAction *)action;

@end
