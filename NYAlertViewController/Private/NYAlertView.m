#import "NYAlertView.h"
#import "NYAlertAction.h"
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
//    [self setBackgroundImage:[self imageWithColor:color] forState:state];
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

@interface NYAlertView ()

@property (nonatomic) NSLayoutConstraint *alertBackgroundWidthConstraint;
@property (nonatomic) UIView *contentViewContainerView;
@property (nonatomic) UIView *textFieldContainerView;
@property (nonatomic) UIView *actionButtonContainerView;
@property (nonatomic) UIStackView *actionButtonStackView;

@end

@implementation NYAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.maximumWidth = 480.0f;
        
        _alertBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.alertBackgroundView setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.alertBackgroundView.backgroundColor = [UIColor colorWithWhite:0.97f alpha:1.0f];
        self.alertBackgroundView.layer.cornerRadius = 6.0f;
        [self addSubview:_alertBackgroundView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
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

        _actionButtonStackView = [[UIStackView alloc] init];
        [self.actionButtonStackView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.actionButtonStackView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.actionButtonContainerView addSubview:self.actionButtonStackView];

        UIView *separatorView = [[UIView alloc] init];
        separatorView.backgroundColor = [UIColor lightGrayColor];
        [separatorView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.alertBackgroundView addSubview:separatorView];
        [separatorView.heightAnchor constraintEqualToConstant:1.0f / [UIScreen mainScreen].scale].active = YES;
        [separatorView.leadingAnchor constraintEqualToAnchor:separatorView.superview.leadingAnchor].active = YES;
        [separatorView.trailingAnchor constraintEqualToAnchor:separatorView.superview.trailingAnchor].active = YES;
        [separatorView.bottomAnchor constraintEqualToAnchor:self.actionButtonStackView.topAnchor].active = YES;

        [self.actionButtonContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_actionButtonStackView]|"
                                                                                               options:0
                                                                                               metrics:nil
                                                                                                 views:NSDictionaryOfVariableBindings(_actionButtonStackView)]];

        [self.actionButtonContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_actionButtonStackView]|"
                                                                                               options:0
                                                                                               metrics:nil
                                                                                                 views:NSDictionaryOfVariableBindings(_actionButtonStackView)]];
        
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
        
        [self.alertBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]-|"
                                                                                         options:0
                                                                                         metrics:nil
                                                                                           views:NSDictionaryOfVariableBindings(_titleLabel)]];
        
        [self.alertBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_messageTextView]-|"
                                                                                         options:0
                                                                                         metrics:nil
                                                                                           views:NSDictionaryOfVariableBindings(_messageTextView)]];
        
        [self.alertBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentViewContainerView]|"
                                                                                         options:0
                                                                                         metrics:nil
                                                                                           views:NSDictionaryOfVariableBindings(_contentViewContainerView)]];
        
        [self.alertBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_textFieldContainerView]|"
                                                                                         options:0
                                                                                         metrics:nil
                                                                                           views:NSDictionaryOfVariableBindings(_textFieldContainerView)]];
        
        [self.alertBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_actionButtonContainerView]|"
                                                                                         options:0
                                                                                         metrics:nil
                                                                                           views:NSDictionaryOfVariableBindings(_actionButtonContainerView)]];
        
        [self.alertBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_titleLabel]-2-[_messageTextView][_contentViewContainerView][_textFieldContainerView]-8-[_actionButtonContainerView]|"
                                                                                         options:0
                                                                                         metrics:nil
                                                                                           views:NSDictionaryOfVariableBindings(_titleLabel,
                                                                                                                                _messageTextView,
                                                                                                                                _contentViewContainerView,
                                                                                                                                _textFieldContainerView,
                                                                                                                                _actionButtonContainerView)]];
    }
    
    return self;
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

//- (void)actionButtonPressed:(NYAlertViewButton *)button {
//    NYAlertAction *action = self.actions[button.tag];
//    action.handler(action);
//}

//- (void)setActions:(NSArray *)actions {
////    _actions = actions;
////    
//    NSMutableArray *buttons = [NSMutableArray array];
//    
//    // Create buttons for each action
//    for (int i = 0; i < [actions count]; i++) {
//        UIAlertAction *action = actions[i];
//        
//        NYAlertViewButton *button = [[NYAlertViewButton alloc] initWithFrame:CGRectZero];
//        
//        button.tag = i;
//        [button addTarget:self action:@selector(actionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//        
//        button.cornerRadius = self.buttonCornerRadius;
//        [button setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [button setTitle:action.title forState:UIControlStateNormal];
//        
//        if (action.style == UIAlertActionStyleCancel) {
//            [button setTitleColor:self.cancelButtonTitleColor forState:UIControlStateNormal];
//            [button setTitleColor:self.cancelButtonTitleColor forState:UIControlStateHighlighted];
//            button.tintColor = self.cancelButtonColor;
//            button.titleLabel.font = self.cancelButtonTitleFont;
//        } else if (action.style == UIAlertActionStyleDestructive) {
//            [button setTitleColor:self.destructiveButtonTitleColor forState:UIControlStateNormal];
//            [button setTitleColor:self.destructiveButtonTitleColor forState:UIControlStateHighlighted];
//            button.tintColor = self.destructiveButtonColor;
//            button.titleLabel.font = self.destructiveButtonTitleFont;
//        } else {
//            [button setTitleColor:self.buttonTitleColor forState:UIControlStateNormal];
//            [button setTitleColor:self.buttonTitleColor forState:UIControlStateHighlighted];
//            button.tintColor = self.buttonColor;
//            button.titleLabel.font = self.buttonTitleFont;
//        }
//        
//        [buttons addObject:button];
//    }
//    
//    self.actionButtons = buttons;
//}

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
            [textField.topAnchor constraintEqualToAnchor:self.contentViewContainerView.layoutMarginsGuide.topAnchor].active = YES;
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
    for (UIView *view  in self.actionButtonStackView.arrangedSubviews) {
        [view removeFromSuperview];
    }
    
    _actionButtons = actionButtons;

    // If there are 2 actions, display the buttons next to each other. Otherwise, stack the buttons vertically at full width
    self.actionButtonStackView.axis = actionButtons.count == 2 ? UILayoutConstraintAxisHorizontal : UILayoutConstraintAxisVertical;
//    self.actionButtonStackView.spacing = actionButtons.count == 2 ? 16.0f : 0.0f;

//    for (UIButton *button in actionButtons) {
//        [self.actionButtonStackView addArrangedSubview:button];
//    }

    [actionButtons enumerateObjectsUsingBlock:^(UIButton *  _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > 0) {
            // Add separator view
            UIView *separatorView = [[UIView alloc] init];
            separatorView.backgroundColor = [UIColor lightGrayColor];
            [separatorView setTranslatesAutoresizingMaskIntoConstraints:NO];

            if (self.actionButtonStackView.axis == UILayoutConstraintAxisVertical) {
                [separatorView.heightAnchor constraintEqualToConstant:1.0f / [UIScreen mainScreen].scale].active = YES;
            } else {
                [separatorView.widthAnchor constraintEqualToConstant:1.0f / [UIScreen mainScreen].scale].active = YES;
            }

            [self.actionButtonStackView addArrangedSubview:separatorView];
        }

        [button setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.actionButtonStackView addArrangedSubview:button];

        if (idx > 0) {
            UIButton *previousButton = actionButtons[idx - 1];
            [button.widthAnchor constraintEqualToAnchor:previousButton.widthAnchor multiplier:1.0f].active = YES;
            [button.heightAnchor constraintEqualToAnchor:previousButton.heightAnchor multiplier:1.0f].active = YES;
        }
    }];
}

@end
