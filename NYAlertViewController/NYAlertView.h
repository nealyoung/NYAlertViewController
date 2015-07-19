//
//  NYAlertView.h
//
//  Created by Nealon Young on 7/13/15.
//  Copyright (c) 2015 Nealon Young. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NYAlertView : UIView

@property UILabel *titleLabel;
@property UILabel *messageLabel;
@property (nonatomic) UIView *contentView;

@property (nonatomic) UIFont *titleFont;
@property (nonatomic) UIFont *messageFont;
@property (nonatomic) UIFont *buttonTitleFont;
@property (nonatomic) UIFont *cancelButtonTitleFont;

@property (nonatomic) CGFloat buttonCornerRadius;

@property UIView *alertBackgroundView;

@property NSLayoutConstraint *backgroundViewVerticalCenteringConstraint;

@property (nonatomic) NSArray *actions;

@end
