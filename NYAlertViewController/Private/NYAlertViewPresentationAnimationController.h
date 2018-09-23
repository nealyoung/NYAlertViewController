#import <UIKit/UIKit.h>
#import "NYAlertViewControllerTransitionStyle.h"

@interface NYAlertViewPresentationAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property NYAlertViewControllerTransitionStyle transitionStyle;
@property CGFloat duration;

@end
