//
//  NYAlertTextView.m
//  NYAlertViewDemo
//
//  Created by Nealon Young on 7/19/15.
//  Copyright (c) 2015 Nealon Young. All rights reserved.
//

#import "NYAlertTextView.h"

@implementation NYAlertTextView

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer {
    self = [super initWithFrame:frame textContainer:textContainer];
    
    self.textContainerInset = UIEdgeInsetsZero;
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!CGSizeEqualToSize(self.bounds.size, [self intrinsicContentSize])) {
        [self invalidateIntrinsicContentSize];
    }
}

- (CGSize)intrinsicContentSize {
    CGSize intrinsicContentSize = self.contentSize;
//    intrinsicContentSize.width += (self.textContainerInset.left + self.textContainerInset.right ) / 2.0f;
//    intrinsicContentSize.height += (self.textContainerInset.top + self.textContainerInset.bottom) / 2.0f;
    
    return intrinsicContentSize;
}

@end
