//
//  NYRoundRectButton.m
//  LockMinder
//
//  Created by Nealon Young on 7/15/15.
//  Copyright (c) 2015 Nealon Young. All rights reserved.
//

#import "NYRoundRectButton.h"

@implementation NYRoundRectButton

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
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [self tintColorDidChange];
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    [self invalidateIntrinsicContentSize];
}

- (void)tintColorDidChange {
    [super tintColorDidChange];
    
    if (self.type == NYRoundRectButtonTypeFilled) {
        self.layer.backgroundColor = self.tintColor.CGColor;
    } else {
        [self setTitleColor:self.tintColor forState:UIControlStateNormal];
    }
    
    self.layer.borderColor = self.tintColor.CGColor;
    
    [self setNeedsDisplay];
}

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

- (void)setType:(NYRoundRectButtonType)type {
    _type = type;
    
    if (type == NYRoundRectButtonTypeBordered) {
        self.layer.backgroundColor = [UIColor clearColor].CGColor;
        [self setTitleColor:self.tintColor forState:UIControlStateNormal];
    } else {
        self.layer.backgroundColor = self.tintColor.CGColor;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (CGSize)intrinsicContentSize {
    if (self.hidden) {
        return CGSizeZero;
    }
    
    return CGSizeMake([super intrinsicContentSize].width + 12.0f, 30.0f);
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
    self.layer.borderWidth = 1.0f;
    
    if (self.state == UIControlStateHighlighted) {
        self.layer.backgroundColor = self.tintColor.CGColor;
//        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    } else {
        if (self.type == NYRoundRectButtonTypeBordered) {
            self.layer.backgroundColor = nil;
            [self setTitleColor:self.tintColor forState:UIControlStateNormal];
        } else {
//            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}

@end
