#import <UIKit/UIKit.h>

@interface NYAlertViewPresentationController : UIPresentationController

@property CGFloat presentedViewControllerHorizontalInset;
@property CGFloat presentedViewControllerVerticalInset;
@property (nonatomic) BOOL backgroundTapDismissalGestureEnabled;
@property UIView *backgroundDimmingView;

@end
