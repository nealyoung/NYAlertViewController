#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NYAlertActionButtonStyle) {
    NYAlertActionButtonStyleDefault,
    NYAlertActionButtonStyleRoundRect,
    NYAlertActionButtonStyleCustomClass
};

NS_ASSUME_NONNULL_BEGIN

@interface NYAlertActionConfiguration : NSObject

@property (nonatomic) NYAlertActionButtonStyle buttonStyle;

/**
 The font used to display the button title.
 */
@property (strong, nonatomic) UIFont *titleFont;

/**
 The text color used to display the button title.
 */
@property (strong, nonatomic) UIColor *titleColor;

/**
 The text color used to display the button title when the action is disabled.
 */
@property (strong, nonatomic) UIColor *disabledTitleColor;
@property (strong, nonatomic) UIColor *backgroundColor;
@property (nonatomic) CGFloat cornerRadius;
@property (strong, nonatomic, nullable) Class buttonClass;

@end

NS_ASSUME_NONNULL_END
