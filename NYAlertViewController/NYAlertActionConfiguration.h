#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYAlertActionConfiguration : NSObject

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

@end

NS_ASSUME_NONNULL_END
