#import "NYAlertViewButton.h"

@implementation NYAlertViewButton

+ (id)buttonWithType:(UIButtonType)buttonType {
    return [super buttonWithType:UIButtonTypeCustom];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self commonInit];
    }

    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [self commonInit];
    }

    return self;
}

- (void)commonInit {
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    self.layer.shouldRasterize = YES;

    self.layer.borderWidth = 1.0f;

    self.cornerRadius = 4.0f;
    self.clipsToBounds = YES;

//    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];

    [self tintColorDidChange];
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    [self invalidateIntrinsicContentSize];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];

    //    if (!enabled) {
    //        self.backgroundColor = [UIColor lightGrayColor];
    //        self.layer.borderColor = self.tintColor.CGColor;
    //        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    //    } else {
    //        self.backgroundColor = self.tintColor;
    //        self.layer.borderColor = self.tintColor.CGColor;
    //        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    }
}
//
//- (void)tintColorDidChange {
//    [super tintColorDidChange];
//
//    switch (self.type) {
//        case NYAlertViewButtonTypeRoundRect:
//            if (self.enabled) {
//                [self setBackgroundColor:self.tintColor];
//            }
//            break;
//        default:
//            break;
//    }
//
////    if (self.type == NYAlertViewButtonTypeFilled) {
////        if (self.enabled) {
////            [self setBackgroundColor:self.tintColor];
////        }
////    } else {
////        [self setTitleColor:self.tintColor forState:UIControlStateNormal];
////    }
//
//    self.layer.borderColor = self.tintColor.CGColor;
//
//    [self setNeedsDisplay];
//}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

//- (void)setEnabled:(BOOL)enabled {
//    [super setEnabled:enabled];
//
//    if (enabled) {
//        self.layer.backgroundColor = self.tintColor.CGColor;
//        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    } else {
//        self.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
//        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    }
//}

//- (void)setType:(NYAlertViewButtonType)type {
//    _type = type;
//
//    if (type == NYAlertViewButtonTypeBordered) {
//        self.layer.backgroundColor = [UIColor clearColor].CGColor;
//        [self setTitleColor:self.tintColor forState:UIControlStateNormal];
//    } else {
//        self.layer.backgroundColor = self.tintColor.CGColor;
//        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    }
//}

- (CGSize)intrinsicContentSize {
    if (self.hidden) {
        return CGSizeZero;
    }

    return CGSizeMake([super intrinsicContentSize].width + 12.0f, 44.0f);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    self.layer.borderColor = self.tintColor.CGColor;

    if (self.type == NYAlertViewButtonTypeBordered) {
        self.layer.borderWidth = 1.0f;
    } else {
        self.layer.borderWidth = 0.0f;
    }

    if (self.state == UIControlStateHighlighted) {
//        self.layer.backgroundColor = self.tintColor.CGColor;
        //        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    } else {
        if (self.type == NYAlertViewButtonTypeBordered) {
            self.layer.backgroundColor = nil;
            [self setTitleColor:self.tintColor forState:UIControlStateNormal];
        } else {
            //            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}

@end
