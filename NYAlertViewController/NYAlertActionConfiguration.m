#import "NYAlertActionConfiguration.h"

@implementation NYAlertActionConfiguration

- (instancetype)init {
    self = [super init];

    if (self) {
        _titleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        _titleColor = [UIColor darkGrayColor];
        _disabledTitleColor = [UIColor grayColor];
    }

    return self;
}

@end
