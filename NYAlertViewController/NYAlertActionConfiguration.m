#import "NYAlertActionConfiguration.h"

@implementation NYAlertActionConfiguration

- (instancetype)init {
    self = [super init];

    if (self) {
        _buttonStyle = NYAlertActionButtonStyleDefault;
        _titleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        _titleColor = [UIColor darkGrayColor];
        _disabledTitleColor = [UIColor grayColor];
        _backgroundColor = [UIColor lightGrayColor];
        _cornerRadius = 8.0f;
    }

    return self;
}

@end
