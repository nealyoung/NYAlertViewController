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
        _alertViewCornerRadius = 6.0f;
        _separatorColor = [UIColor lightGrayColor];
        _buttonTitleColor = [UIColor darkGrayColor];
        _cancelButtonTitleColor = [UIColor darkGrayColor];
        _destructiveButtonTitleColor = [UIColor colorWithRed:1.0f green:0.23f blue:0.21f alpha:1.0f];
        _disabledButtonTitleColor = [UIColor lightGrayColor];
    }

    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    // TODO: Implement this
    return self;
}

@end
