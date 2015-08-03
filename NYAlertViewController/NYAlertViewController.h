//
//  NYAlertViewController.h
//
//  Created by Nealon Young on 7/13/15.
//  Copyright (c) 2015 Nealon Young. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NYAlertAction : NSObject

+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(NYAlertAction *action))handler;

@property (nonatomic) NSString *title;
@property (nonatomic) UIAlertActionStyle style;
@property (nonatomic, strong) void (^handler)(NYAlertAction *action);

@end

@interface NYAlertViewController : UIViewController

/**
 The message displayed under the alert view's title
 */
@property (nonatomic) NSString *message;

/**
 The custom view displayed in the presented alert view
 
 @discussion The default value of this property is nil. Set this property to a view that you create to add the custom view to the displayed alert view.
 */
@property (nonatomic) UIView *alertViewContentView;

/**
 A Boolean value that determines whether the user can tap on the dimmed background surrounding the presented alert view to dismiss the alert view controller without any action handlers being executed
 
 @discussion The default value is NO
 */
@property (nonatomic) BOOL backgroundTapDismissalGestureEnabled;

/**
 A Boolean value that determines whether the user can swipe up or down on the presented alert view to dismiss the alert view controller without any action handlers being executed
 
 @discussion The default value is NO
 */
@property (nonatomic) BOOL swipeDismissalGestureEnabled;

/**
 The background color of the alert view
 */
@property (nonatomic) UIColor *alertViewBackgroundColor;

/**
 The maximum width at which to display the presented alert view
 */
@property (nonatomic) CGFloat maximumWidth;

/**
 The font used to display the title in the alert view
 
 @see title
 */
@property (nonatomic) UIFont *titleFont;

/**
 The font used to display the messsage in the alert view
 
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
 The color used to display the title for buttons corresponsing to default style actions
 */
@property (nonatomic) UIColor *buttonTitleColor;

/**
 The color used to display the title for buttons corresponsing to cancel style actions
 */
@property (nonatomic) UIColor *cancelButtonTitleColor;

/**
 The color used to display the title for buttons corresponsing to destructive style actions
 */
@property (nonatomic) UIColor *destructiveButtonTitleColor;

/**
 The radius of the displayed alert view's corners
 */
@property (nonatomic) CGFloat alertViewCornerRadius;

/**
 The radius of button corners
 */
@property (nonatomic) CGFloat buttonCornerRadius;

/**
 An array of NYAlertAction objects representing the actions that the user can take in response to the alert view
 */
@property (nonatomic, readonly) NSArray *actions;

/**
 Add an alert action object to be displayed in the alert view
 
 @param action The action object to display in the alert view to be presented
 */
- (void)addAction:(NYAlertAction *)action;

@end
