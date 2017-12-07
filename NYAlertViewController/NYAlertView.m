//
//  NYAlertView.m
//
//  Created by Nealon Young on 7/13/15.
//  Copyright (c) 2015 Nealon Young. All rights reserved.
//

#import "NYAlertView.h"

#import "NYAlertViewController.h"

@interface NYAlertTextView : UITextView

@end

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
    if ([self.text length]) {
        return self.contentSize;
    } else {
        return CGSizeZero;
    }
}

@end

@implementation UIButton (BackgroundColor)

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state {
    [self setBackgroundImage:[self imageWithColor:color] forState:state];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

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
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    
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

- (void)tintColorDidChange {
    [super tintColorDidChange];
    
    if (self.type == NYAlertViewButtonTypeFilled) {
        if (self.enabled) {
            [self setBackgroundColor:self.tintColor];
        }
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
    
    self.layer.borderColor = _borderColor ? _borderColor.CGColor : self.tintColor.CGColor;
    
    if (self.type == NYAlertViewButtonTypeBordered) {
        self.layer.borderWidth = (_borderWidth > 0) ? _borderWidth : 1.0f;
    } else {
        self.layer.borderWidth = 0.0f;
    }
    
    if (self.state == UIControlStateHighlighted) {
        self.layer.backgroundColor = self.tintColor.CGColor;
        //        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    } else {
        if (self.type == NYAlertViewButtonTypeBordered) {
            self.layer.backgroundColor = nil;
            [self setTitleColor:_borderedTitleColor ? _borderedTitleColor : self.tintColor forState:UIControlStateNormal];
        } else {
            //            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}

@end

@interface NYAlertView ()

@property (nonatomic) NSLayoutConstraint *alertBackgroundWidthConstraint;
@property (nonatomic) UIView *contentViewContainerView;
@property (nonatomic) UIView *textFieldContainerView;
@property (nonatomic) UIView *actionButtonContainerView;
@property (nonatomic) UITextField *activeTextField;

@end

@implementation NYAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithStyle:(NYAlertViewStyle)style
{
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        self.style = style;
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit
{
    self.maximumWidth = 480.0f;
    
    _alertBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.alertBackgroundView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.alertBackgroundView.backgroundColor = [UIColor colorWithWhite:0.97f alpha:1.0f];
    self.alertBackgroundView.layer.cornerRadius = 6.0f;
    [self addSubview:_alertBackgroundView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor darkGrayColor];
    self.titleLabel.text = NSLocalizedString(@"Title Label", nil);
    [self.alertBackgroundView addSubview:self.titleLabel];
    
    _messageTextView = [[NYAlertTextView alloc] initWithFrame:CGRectZero];
    [self.messageTextView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.messageTextView.backgroundColor = [UIColor clearColor];
    [self.messageTextView setContentHuggingPriority:0 forAxis:UILayoutConstraintAxisVertical];
    [self.messageTextView setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    self.messageTextView.editable = NO;
    self.messageTextView.textAlignment = NSTextAlignmentCenter;
    self.messageTextView.textColor = [UIColor darkGrayColor];
    self.messageTextView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    self.messageTextView.text = NSLocalizedString(@"Message Text View", nil);
    self.messageTextView.textContainerInset = (self.style == NYAlertViewStyleIOSCustom) ? UIEdgeInsetsMake(7, 0, 0, 0) : self.messageTextView.textContainerInset;
    [self.alertBackgroundView addSubview:self.messageTextView];
    
    _contentViewContainerView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.contentViewContainerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.alertBackgroundView addSubview:self.contentViewContainerView];
    
    _textFieldContainerView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.textFieldContainerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.textFieldContainerView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.alertBackgroundView addSubview:self.textFieldContainerView];
    
    _actionButtonContainerView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.actionButtonContainerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.actionButtonContainerView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.alertBackgroundView addSubview:self.actionButtonContainerView];
    
    UIView *topSeparatorView;
    UIView *bottomSeparatorView;
    
    if (self.style == NYAlertViewStyleIOSCustom) {
        topSeparatorView = [UIView new];
        [topSeparatorView setTranslatesAutoresizingMaskIntoConstraints:NO];
        topSeparatorView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
        [self.alertBackgroundView addSubview:topSeparatorView];
        
        bottomSeparatorView = [UIView new];
        [bottomSeparatorView setTranslatesAutoresizingMaskIntoConstraints:NO];
        bottomSeparatorView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
        [self.alertBackgroundView addSubview:bottomSeparatorView];
    }
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.alertBackgroundView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0f
                                                      constant:0.0f]];
    
    CGFloat alertBackgroundViewWidth = MIN(CGRectGetWidth([UIApplication sharedApplication].keyWindow.bounds),
                                           CGRectGetHeight([UIApplication sharedApplication].keyWindow.bounds)) * 0.8f;
    
    if (alertBackgroundViewWidth > self.maximumWidth) {
        alertBackgroundViewWidth = self.maximumWidth;
    }
    
    _alertBackgroundWidthConstraint = [NSLayoutConstraint constraintWithItem:self.alertBackgroundView
                                                                   attribute:NSLayoutAttributeWidth
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:0.0f
                                                                    constant:alertBackgroundViewWidth];
    
    [self addConstraint:self.alertBackgroundWidthConstraint];
    
    _backgroundViewVerticalCenteringConstraint = [NSLayoutConstraint constraintWithItem:self.alertBackgroundView
                                                                              attribute:NSLayoutAttributeCenterY
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self
                                                                              attribute:NSLayoutAttributeCenterY
                                                                             multiplier:1.0f
                                                                               constant:0.0f];
    
    [self addConstraint:self.backgroundViewVerticalCenteringConstraint];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.alertBackgroundView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0.9f
                                                      constant:0.0f]];
    
    [self.alertBackgroundView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]-|"
                                             options:0
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(_titleLabel)]];
    
    [self.alertBackgroundView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_messageTextView]-|"
                                             options:0
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(_messageTextView)]];
    
    [self.alertBackgroundView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentViewContainerView]|"
                                             options:0
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(_contentViewContainerView)]];
    
    [self.alertBackgroundView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_textFieldContainerView]|"
                                             options:0
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(_textFieldContainerView)]];
    
    [self.alertBackgroundView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_actionButtonContainerView]|"
                                             options:0
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(_actionButtonContainerView)]];
    
    NSString *format = (self.style == NYAlertViewStyleIOSCustom)
    ? @"V:|-[_titleLabel]-[topSeparatorView]-0-[_messageTextView][_contentViewContainerView][_textFieldContainerView][bottomSeparatorView][_actionButtonContainerView]-0-|"
    : @"V:|-[_titleLabel]-2-[_messageTextView][_contentViewContainerView][_textFieldContainerView][_actionButtonContainerView]-|";
    NSDictionary *views = (topSeparatorView)
    ? NSDictionaryOfVariableBindings(_titleLabel, topSeparatorView, _messageTextView, _contentViewContainerView, _textFieldContainerView, bottomSeparatorView, _actionButtonContainerView)
    : NSDictionaryOfVariableBindings(_titleLabel, _messageTextView, _contentViewContainerView, _textFieldContainerView, _actionButtonContainerView);
    
    [self.alertBackgroundView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:format
                                             options:0
                                             metrics:nil
                                               views:views]];
    
    if (self.style == NYAlertViewStyleIOSCustom) {
        [self.alertBackgroundView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:[topSeparatorView(1)]"
                                                 options:0
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(topSeparatorView)]];
        [self.alertBackgroundView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[topSeparatorView]-0-|"
                                                 options:0
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(topSeparatorView)]];
        [self.alertBackgroundView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:[bottomSeparatorView(1)]"
                                                 options:0
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(bottomSeparatorView)]];
        [self.alertBackgroundView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bottomSeparatorView]-0-|"
                                                 options:0
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(bottomSeparatorView)]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShowNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHideNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidBeginEditingNotification:)
                                                 name:UITextFieldTextDidBeginEditingNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidEndEditingNotification:)
                                                 name:UITextFieldTextDidEndEditingNotification
                                               object:nil];
}

// Pass through touches outside the backgroundView for the presentation controller to handle dismissal
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView *subview in self.subviews) {
        if ([subview hitTest:[self convertPoint:point toView:subview] withEvent:event]) {
            return YES;
        }
    }
    
    return NO;
}

- (void)setMaximumWidth:(CGFloat)maximumWidth {
    _maximumWidth = maximumWidth;
    self.alertBackgroundWidthConstraint.constant = maximumWidth;
}

- (void)setContentView:(UIView *)contentView {
    [self.contentView removeFromSuperview];
    
    _contentView = contentView;
    
    if (contentView) {
        [self.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentViewContainerView addSubview:self.contentView];
        
        [self.contentViewContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentView]|"
                                                                                              options:0
                                                                                              metrics:nil
                                                                                                views:NSDictionaryOfVariableBindings(_contentView)]];
        
        [self.contentViewContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[_contentView]-2-|"
                                                                                              options:0
                                                                                              metrics:nil
                                                                                                views:NSDictionaryOfVariableBindings(_contentView)]];
    }
}

- (void)setTextFields:(NSArray *)textFields {
    for (UITextField *textField in self.textFields) {
        [textField removeFromSuperview];
    }
    
    _textFields = textFields;
    
    for (int i = 0; i < [textFields count]; i++) {
        UITextField *textField = textFields[i];
        [textField setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.textFieldContainerView addSubview:textField];
        
        [self.textFieldContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[textField]-|"
                                                                                            options:0
                                                                                            metrics:nil
                                                                                              views:NSDictionaryOfVariableBindings(textField)]];
        
        // Pin the first text field to the top of the text field container view
        if (i == 0) {
            [self.textFieldContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[textField]"
                                                                                                options:0
                                                                                                metrics:nil
                                                                                                  views:NSDictionaryOfVariableBindings(_contentViewContainerView, textField)]];
        } else {
            UITextField *previousTextField = textFields[i - 1];
            
            [self.textFieldContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[previousTextField]-[textField]"
                                                                                                options:0
                                                                                                metrics:nil
                                                                                                  views:NSDictionaryOfVariableBindings(previousTextField, textField)]];
        }
        
        // Pin the final text field to the bottom of the text field container view
        if (i == ([textFields count] - 1)) {
            [self.textFieldContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[textField]|"
                                                                                                options:0
                                                                                                metrics:nil
                                                                                                  views:NSDictionaryOfVariableBindings(textField)]];
        }
    }
}

- (void)setActionButtons:(NSArray *)actionButtons {
    for (UIButton *button in self.actionButtons) {
        [button removeFromSuperview];
    }
    
    self.alertBackgroundView.clipsToBounds = (self.style == NYAlertViewStyleIOSCustom);
    
    _actionButtons = actionButtons;
    
    // If there are 2 actions, display the buttons next to each other. Otherwise, stack the buttons vertically at full width
    if ([actionButtons count] == 2) {
        UIButton *firstButton = actionButtons[0];
        UIButton *lastButton = actionButtons[1];
        UIView *separatorView;
        
        [self.actionButtonContainerView addSubview:firstButton];
        [self.actionButtonContainerView addSubview:lastButton];
        
        if (self.style == NYAlertViewStyleIOSCustom) {
            separatorView = [UIView new];
            [separatorView setTranslatesAutoresizingMaskIntoConstraints:NO];
            separatorView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
            [self.actionButtonContainerView addSubview:separatorView];
            
            [self.actionButtonContainerView addConstraints:
             [NSLayoutConstraint constraintsWithVisualFormat:@"H:[separatorView(1)]"
                                                     options:0
                                                     metrics:nil
                                                       views:NSDictionaryOfVariableBindings(separatorView)]];
            [self.actionButtonContainerView addConstraints:
             [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[separatorView]-0-|"
                                                     options:0
                                                     metrics:nil
                                                       views:NSDictionaryOfVariableBindings(separatorView)]];
        }
        
        [self.actionButtonContainerView addConstraint:
         [NSLayoutConstraint constraintWithItem:firstButton
                                      attribute:NSLayoutAttributeWidth
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:lastButton
                                      attribute:NSLayoutAttributeWidth
                                     multiplier:1.0f
                                       constant:0.0f]];
        
        NSString *format = (self.style == NYAlertViewStyleIOSCustom)
        ? @"H:|-0-[firstButton]-0-[separatorView]-0-[lastButton]-0-|"
        : @"H:|-[firstButton]-[lastButton]-|";
        
        NSDictionary *views = (self.style == NYAlertViewStyleIOSCustom)
        ? NSDictionaryOfVariableBindings(firstButton, separatorView, lastButton)
        : NSDictionaryOfVariableBindings(firstButton, lastButton);
        
        [self.actionButtonContainerView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:format
                                                 options:NSLayoutFormatAlignAllCenterY
                                                 metrics:nil
                                                   views:views]];
        
        format = (self.style == NYAlertViewStyleIOSCustom)
        ? @"V:|-0-[firstButton(40)]-0-|"
        : @"V:|-[firstButton(40)]|";
        
        [self.actionButtonContainerView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:format
                                                 options:0
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(_contentViewContainerView, firstButton)]];
        
        [self.actionButtonContainerView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:[lastButton(40)]"
                                                 options:0
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(lastButton)]];
    } else {
        for (int i = 0; i < [actionButtons count]; i++) {
            UIButton *actionButton = actionButtons[i];
            
            [self.actionButtonContainerView addSubview:actionButton];
            
            [self.actionButtonContainerView addConstraints:
             [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[actionButton]-|"
                                                     options:0
                                                     metrics:nil
                                                       views:NSDictionaryOfVariableBindings(actionButton)]];
            
            [self.actionButtonContainerView addConstraints:
             [NSLayoutConstraint constraintsWithVisualFormat:@"V:[actionButton(40)]"
                                                     options:0
                                                     metrics:nil
                                                       views:NSDictionaryOfVariableBindings(actionButton)]];
            
            if (i == 0) {
                [self.actionButtonContainerView addConstraints:
                 [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[actionButton]"
                                                         options:0
                                                         metrics:nil
                                                           views:NSDictionaryOfVariableBindings(_contentViewContainerView, actionButton)]];
            } else {
                UIButton *previousButton = actionButtons[i - 1];
                
                [self.actionButtonContainerView addConstraints:
                 [NSLayoutConstraint constraintsWithVisualFormat:@"V:[previousButton]-[actionButton]"
                                                         options:0
                                                         metrics:nil
                                                           views:NSDictionaryOfVariableBindings(previousButton, actionButton)]];
            }
            
            if (i == ([actionButtons count] - 1)) {
                [self.actionButtonContainerView addConstraints:
                 [NSLayoutConstraint constraintsWithVisualFormat:@"V:[actionButton]|"
                                                         options:0
                                                         metrics:nil
                                                           views:NSDictionaryOfVariableBindings(actionButton)]];
            }
        }
    }
}

#pragma mark - Notifications

- (void)keyboardWillShowNotification:(NSNotification *)notification
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight ) {
        CGSize origKeySize = keyboardSize;
        keyboardSize.height = origKeySize.width;
        keyboardSize.width = origKeySize.height;
    }

    CGFloat keyboardTop = [[UIScreen mainScreen] bounds].size.height - keyboardSize.height;
    CGPoint textFieldPosition = [self convertPoint:CGPointZero fromView:_activeTextField];
    CGFloat textFieldBottom = textFieldPosition.y + _activeTextField.frame.size.height;
    
    if (textFieldBottom > keyboardTop) {
        _backgroundViewVerticalCenteringConstraint.constant = keyboardTop - textFieldBottom;
        [self setNeedsUpdateConstraints];
        
        [UIView animateWithDuration:0.2f animations:^{
            [self layoutIfNeeded];
        }];
    }
}

- (void)keyboardWillHideNotification:(NSNotification *)notification
{
    _backgroundViewVerticalCenteringConstraint.constant = 0.0f;
    [self setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.2f animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)textFieldDidBeginEditingNotification:(NSNotification *)notification
{
    _activeTextField = notification.object;
}

- (void)textFieldDidEndEditingNotification:(NSNotification *)notification
{
    _activeTextField = nil;
}

@end
