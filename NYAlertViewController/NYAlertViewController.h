#import <UIKit/UIKit.h>
#import "NYAlertAction.h"
#import "NYAlertViewControllerConfiguration.h"

typedef NS_ENUM(NSInteger, NYAlertViewButtonStyle) {
    NYAlertViewButtonStyleDefault,
    NYAlertViewButtonStyleDefaultWithSeparators,
    NYAlertViewButtonStyleRoundRect
};

@interface NYAlertViewController : UIViewController

- (instancetype)initWithOptions:(nullable NYAlertViewControllerConfiguration *)configuration
                          title:(nullable NSString *)title
                        message:(nullable NSString *)message
                        actions:(NSArray<NYAlertAction *> *)actions NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

/**
 The configuration object used to initialize the alert view controller.
 */
@property (nonatomic, readonly) NYAlertViewControllerConfiguration *configuration;

/**
 The message displayed under the alert view's title.
 */
@property (nonatomic) NSString *message;

/**
 A Boolean value that determines whether the status bar is visible when the alert view is presented.
 */
@property (nonatomic) BOOL showsStatusBar;

/**
 The custom view displayed in the presented alert view
 
 @discussion The default value of this property is nil. Set this property to a view that you create to add the custom view to the displayed alert view.
 */
@property (nonatomic) UIView *alertViewContentView;

/**
 The maximum width at which to display the presented alert view.
 */
@property (nonatomic) CGFloat maximumWidth;

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

/**
 The font used for buttons (actions with style NYAlertActionStyleDefault) in the alert view
 */
@property (nonatomic) UIFont *buttonTitleFont;

/**
 The font used for cancel buttons (actions with style NYAlertActionStyleCancel) in the alert view
 */
@property (nonatomic) UIFont *cancelButtonTitleFont;

/**
 The font used for destructive buttons (actions with style NYAlertActionStyleDestructive) in the alert view
 */
@property (nonatomic) UIFont *destructiveButtonTitleFont;

/**
 The color used to display the alert view's title
 
 @see title
 */
@property (nonatomic) UIColor *titleColor;

/**
 The color used to display the alert view's message
 
 @see message
 */
@property (nonatomic) UIColor *messageColor;

/**
 The background color for the alert view's buttons corresponsing to default style actions
 */
@property (nonatomic) UIColor *buttonColor;

/**
 The background color for the alert view's buttons corresponsing to cancel style actions
 */
@property (nonatomic) UIColor *cancelButtonColor;

/**
 The background color for the alert view's buttons corresponsing to destructive style actions
 */
@property (nonatomic) UIColor *destructiveButtonColor;

/**
 The background color for the alert view's buttons corresponsing to disabled actions
 */
@property (nonatomic) UIColor *disabledButtonColor;

/**
 The radius of the displayed alert view's corners
 */
@property (nonatomic) CGFloat alertViewCornerRadius;

/**
 An array of NYAlertAction objects representing the actions that the user can take in response to the alert view
 */
@property (nonatomic, readonly) NSArray *actions;

/**
 An array of UITextField objects displayed by the alert view
 
 @see addTextFieldWithConfigurationHandler:
 */
@property (nonatomic, readonly) NSArray *textFields;

/**
 Add a text field object to be displayed in the alert view
 
 @param configurationHandler A block used to configure the text field. The block takes the text field object as a parameter, and can modify the properties of the text field prior to being displayed.
 */
- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler;

@end
