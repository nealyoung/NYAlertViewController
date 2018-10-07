#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NYAlertActionButtonStyle) {
    NYAlertActionButtonStyleDefault,
    NYAlertActionButtonStyleRoundRect,
    NYAlertActionButtonStyleCustomClass
};

NS_ASSUME_NONNULL_BEGIN

@interface NYAlertActionConfiguration : NSObject

@property (nonatomic) NYAlertActionButtonStyle buttonStyle;
@property (strong, nonatomic) UIFont *titleFont;
@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIColor *disabledTextColor;
@property (strong, nonatomic) UIColor *backgroundColor;
@property (nonatomic) CGFloat cornerRadius;
@property (strong, nonatomic, nullable) Class buttonClass;

@end

NS_ASSUME_NONNULL_END
