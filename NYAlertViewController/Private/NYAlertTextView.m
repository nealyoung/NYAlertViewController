#import "NYAlertTextView.h"

@interface NYAlertTextView ()

@property (strong, nonatomic) NSLayoutConstraint *heightConstraint;

@end

@implementation NYAlertTextView

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer {
    self = [super initWithFrame:frame textContainer:textContainer];

    if (self) {
        self.heightConstraint = [self.heightAnchor constraintEqualToConstant:0.0f];
        self.heightConstraint.priority = UILayoutPriorityDefaultHigh;
        self.heightConstraint.active = YES;

        self.textContainerInset = UIEdgeInsetsZero;
    }

    return self;
}

- (void)setText:(NSString *)text {
    [super setText:text];

    [self updateHeightConstraint];
}

- (void)updateHeightConstraint {
    self.heightConstraint.constant = [self sizeThatFits:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)].height;
}

- (void)setBounds:(CGRect)bounds {
    CGRect oldBounds = self.bounds;

    [super setBounds:bounds];

    if (!CGSizeEqualToSize(oldBounds.size, bounds.size)) {
        [self updateHeightConstraint];
    }
}

@end
