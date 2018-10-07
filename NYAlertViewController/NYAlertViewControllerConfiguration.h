#import <UIKit/UIKit.h>
#import "NYAlertActionConfiguration.h"
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
 A Boolean value that determines whether the action buttons are always arranged vertically. When set to NO, alert views with 2 actions will have the buttons arranged side-to-side.

 @discussion The default value is NO
 */
@property (nonatomic) BOOL alwaysArrangesActionButtonsVertically;

/**
 The background color of the alert view.

 @discussion The default value is opaque white
 */
@property (nonatomic) UIColor *alertViewBackgroundColor;

/**
 The radius of the displayed alert view's corners
 */
@property (nonatomic) CGFloat alertViewCornerRadius;

/**
 The color used to display the alert view's title

 @see title
 */
@property (nonatomic) UIColor *titleTextColor;

/**
 The color used to display the alert view's message

 @see message
 */
@property (nonatomic) UIColor *messageTextColor;

/**
 The color used for separators between action buttons.

 @discussion The default value is the system light gray color
 */
@property (nonatomic) UIColor *separatorColor;

/**
 The font used to display the title in the alert view.

 @see title
 */
@property (nonatomic) UIFont *titleFont;

/**
 The font used to display the messsage in the alert view.

 @see message
 */
@property (nonatomic) UIFont *messageFont;

@property (nonatomic, strong) NYAlertActionConfiguration *buttonConfiguration;
@property (nonatomic, strong) NYAlertActionConfiguration *destructiveButtonConfiguration;
@property (nonatomic, strong) NYAlertActionConfiguration *cancelButtonConfiguration;

@end

NS_ASSUME_NONNULL_END
