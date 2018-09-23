#import <UIKit/UIKit.h>
#import "NYAlertViewControllerTransitionStyle.h"

@interface NYAlertViewDismissalAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property NYAlertViewControllerTransitionStyle transitionStyle;
@property CGFloat duration;

@end
