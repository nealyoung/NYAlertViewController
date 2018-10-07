#import "NYAlertViewControllerConfiguration.h"

@implementation NYAlertViewControllerConfiguration

- (instancetype)init {
    self = [super init];

    if (self) {
        _showsStatusBar = YES;
        _transitionStyle = NYAlertViewControllerTransitionStyleSlideFromTop;

        _backgroundTapDismissalGestureEnabled = NO;
        _swipeDismissalGestureEnabled = NO;

        _titleTextColor = [UIColor darkGrayColor];
        _messageTextColor = [UIColor darkGrayColor];
        _alertViewBackgroundColor = [UIColor whiteColor];
        _alertViewCornerRadius = 6.0f;
        _separatorColor = [UIColor lightGrayColor];
        _buttonTitleColor = [UIColor darkGrayColor];
        _cancelButtonTitleColor = [UIColor darkGrayColor];
        _destructiveButtonTitleColor = [UIColor colorWithRed:1.0f green:0.23f blue:0.21f alpha:1.0f];
        _disabledButtonTitleColor = [UIColor lightGrayColor];

        _titleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        _messageFont = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        _buttonTitleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        _cancelButtonTitleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        _destructiveButtonTitleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];

        _buttonConfiguration = [NYAlertActionConfiguration new];
        _destructiveButtonConfiguration = [NYAlertActionConfiguration new];
        _cancelButtonConfiguration = [NYAlertActionConfiguration new];
    }

    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    // TODO: Implement this
    return self;
}

@end
