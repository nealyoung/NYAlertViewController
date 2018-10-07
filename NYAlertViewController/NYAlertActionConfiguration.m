#import "NYAlertActionConfiguration.h"

@implementation NYAlertActionConfiguration

- (instancetype)init {
    self = [super init];

    if (self) {
        _buttonStyle = NYAlertActionButtonStyleDefault;
        _titleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        _textColor = [UIColor darkGrayColor];
        _disabledTextColor = [UIColor grayColor];
        _backgroundColor = [UIColor lightGrayColor];
        _cornerRadius = 8.0f;
    }

    return self;
}

@end
