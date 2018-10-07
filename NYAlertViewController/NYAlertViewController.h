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
                        actions:(NSArray<NYAlertAction *> *)actions;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
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
 The custom view displayed in the presented alert view
 
 @discussion The default value of this property is nil. Set this property to a view that you create to add the custom view to the displayed alert view.
 */
@property (nonatomic) UIView *alertViewContentView;

/**
 The maximum width at which to display the presented alert view.
 */
@property (nonatomic) CGFloat maximumWidth;

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
 An array of NYAlertAction objects representing the actions that the user can take in response to the alert view
 */
@property (nonatomic, readonly) NSArray<NYAlertAction *> *actions;

/**
 An array of UITextField objects displayed by the alert view
 
 @see addTextFieldWithConfigurationHandler:
 */
@property (nonatomic, readonly) NSArray<UITextField *> *textFields;

/**
 Add a text field object to be displayed in the alert view
 
 @param configurationHandler A block used to configure the text field. The block takes the text field object as a parameter, and can modify the properties of the text field prior to being displayed.
 */
- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler;

@end
