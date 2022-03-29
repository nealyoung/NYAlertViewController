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

typedef NS_ENUM(NSInteger, NYAlertViewStyle) {
    NYAlertViewStyleDefault,
    NYAlertViewStyleIOSCustom
};

@interface UIButton (BackgroundColor)

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

@end

@interface NYAlertTextView : UITextView
@end

@interface NYAlertViewButton : UIButton

@property (nonatomic) NYAlertViewButtonType type;

@property (nonatomic) UIColor *borderColor;
@property (nonatomic) UIColor *borderedTitleColor;

@property (nonatomic) CGFloat borderWidth;
@property (nonatomic) CGFloat cornerRadius;

@end

@interface NYAlertView : UIView

- (instancetype)initWithStyle:(NYAlertViewStyle)style;

@property (nonatomic) NYAlertViewStyle style;

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) NYAlertTextView *messageTextView;
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

@property (nonatomic) NSString *title;
@property (nonatomic) CGFloat buttonCornerRadius;
@property (nonatomic) CGFloat maximumWidth;
/**
 * Shows content in full screen mode (but not covering status bar).
 */
@property (nonatomic) BOOL isFullScreen;

@property (nonatomic, readonly) UIView *alertBackgroundView;

@property (nonatomic, readonly) NSLayoutConstraint *backgroundViewVerticalCenteringConstraint;
@property (nonatomic, readonly) NSLayoutConstraint *messageTextViewHeightConstraint;

//@property (nonatomic) NSArray *actions;
@property (nonatomic) NSArray<UIButton *> *actionButtons;

@property (nonatomic) NSArray<UITextField *> *textFields;

/// View from contentView which should be visible, overrides first responder / active text field
@property (nonatomic) UIView *keyboardEscapingView;

- (void)updateMessageTextViewHeight;

@end
