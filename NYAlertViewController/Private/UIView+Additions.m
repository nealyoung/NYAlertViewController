#import "UIView+Additions.h"

@implementation UIView (Additions)

- (void)ny_pinEdgesToSuperviewEdges {
    NSAssert(self.superview, @"Superview must be nonnull");
    self.translatesAutoresizingMaskIntoConstraints = NO;

    [self.leadingAnchor constraintEqualToAnchor:self.superview.leadingAnchor].active = YES;
    [self.trailingAnchor constraintEqualToAnchor:self.superview.trailingAnchor].active = YES;
    [self.topAnchor constraintEqualToAnchor:self.superview.topAnchor].active = YES;
    [self.bottomAnchor constraintEqualToAnchor:self.superview.bottomAnchor].active = YES;
}

@end
