#import <UIKit/UIKit.h>
#import "NYAlertViewControllerTransitionStyle.h"

NS_ASSUME_NONNULL_BEGIN

@interface NYAlertViewControllerConfiguration : NSObject <NSCopying>

/**
 A Boolean value that determines whether the status bar is visible when the alert view is presented

 @discussion The default value is YES
 */
@property (nonatomic) BOOL showsStatusBar;

/**
 The transition style used to animate the alert view's presentation/dismissal transitions.

 @discussion The default value is NYAlertViewControllerTransitionStyleSlideFromTop.
 */
@property (nonatomic) NYAlertViewControllerTransitionStyle transitionStyle;

/**
 A Boolean value that determines whether the user can tap on the dimmed background surrounding the presented alert view to dismiss the alert view controller without any action handlers being executed.

 @discussion The default value is NO
 */
@property (nonatomic) BOOL backgroundTapDismissalGestureEnabled;

/**
 A Boolean value that determines whether the user can swipe up or down on the presented alert view to dismiss the alert view controller without any action handlers being executed.

 @discussion The default value is NO
 */
@property (nonatomic) BOOL swipeDismissalGestureEnabled;

/**
 The background color of the alert view.

 @discussion The default value is opaque white
 */
@property (nonatomic) UIColor *alertViewBackgroundColor;

/**
 The color used for separators between action buttons.

 @discussion The default value is the system light gray color
 */
@property (nonatomic) UIColor *separatorColor;

/**
 The color used to display the title for buttons corresponsing to default style actions.
 */
@property (nonatomic) UIColor *buttonTitleColor;

/**
 The color used to display the title for buttons corresponding to cancel style actions.
 */
@property (nonatomic) UIColor *cancelButtonTitleColor;

/**
 The color used to display the title for buttons corresponsing to destructive style actions.
 */
@property (nonatomic) UIColor *destructiveButtonTitleColor;

/**
 The color used to display the title for buttons corresponsing to disabled actions.
 */
@property (nonatomic) UIColor *disabledButtonTitleColor;

@end

NS_ASSUME_NONNULL_END
