//
//  NYAlertView.h
//
//  Created by Nealon Young on 7/13/15.
//  Copyright (c) 2015 Nealon Young. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NYAlertViewButtonType) {
    NYAlertViewButtonTypeFilled,
    NYAlertViewButtonTypeBordered
};

@interface UIButton (BackgroundColor)

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

@end

@interface NYAlertViewButton : UIButton

@property (nonatomic) NYAlertViewButtonType type;

@property (nonatomic) CGFloat cornerRadius;

@end

@interface NYAlertView : UIView

@property UILabel *titleLabel;
@property UITextView *messageTextView;
@property (nonatomic) UIView *contentView;

@property (nonatomic) UIFont *buttonTitleFont;
@property (nonatomic) UIFont *cancelButtonTitleFont;
@property (nonatomic) UIFont *destructiveButtonTitleFont;

@property (nonatomic) UIColor *buttonColor;
@property (nonatomic) UIColor *buttonTitleColor;
@property (nonatomic) UIColor *cancelButtonColor;
@property (nonatomic) UIColor *cancelButtonTitleColor;
@property (nonatomic) UIColor *destructiveButtonColor;
@property (nonatomic) UIColor *destructiveButtonTitleColor;

@property (nonatomic) CGFloat buttonCornerRadius;
@property (nonatomic) CGFloat maximumWidth;

@property (nonatomic, readonly) UIView *alertBackgroundView;

@property (nonatomic, readonly) NSLayoutConstraint *backgroundViewVerticalCenteringConstraint;

//@property (nonatomic) NSArray *actions;
@property (nonatomic) NSArray *actionButtons;

@property (nonatomic) NSArray *textFields;

@end
