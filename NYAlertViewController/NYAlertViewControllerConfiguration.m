#import "NYAlertViewControllerConfiguration.h"

@implementation NYAlertViewControllerConfiguration

- (instancetype)init {
    self = [super init];

    if (self) {
        _showsStatusBar = YES;
        _transitionStyle = NYAlertViewControllerTransitionStyleSlideFromTop;

        _backgroundTapDismissalGestureEnabled = NO;
        _swipeDismissalGestureEnabled = NO;

        _alertViewBackgroundColor = [UIColor whiteColor];
        _separatorColor = [UIColor lightGrayColor];
        _buttonTitleColor = [UIColor darkGrayColor];
        _cancelButtonTitleColor = [UIColor darkGrayColor];
        _destructiveButtonTitleColor = [UIColor darkGrayColor];
        _disabledButtonTitleColor = [UIColor lightGrayColor];
    }

    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    id copy = [[[self class] allocWithZone:zone] init];
    
    return self;
}

@end
