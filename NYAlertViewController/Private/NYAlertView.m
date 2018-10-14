#import "NYAlertView.h"
#import "NYAlertTextView.h"
#import "NYAlertAction.h"
#import "NYAlertViewController.h"
#import "UIView+Additions.h"

@interface NYAlertView ()

@property (nonatomic) NYAlertViewControllerConfiguration *configuration;
@property (nonatomic) NSLayoutConstraint *alertBackgroundWidthConstraint;
@property (nonatomic, readonly) UIView *alertBackgroundView;
@property (nonatomic) UIView *contentViewContainerView;
@property (nonatomic) UIView *textFieldContainerView;
@property (nonatomic) UIView *actionButtonContainerView;
@property (nonatomic) UIStackView *actionButtonStackView;

@end

@implementation NYAlertView

- (instancetype)initWithConfiguration:(NYAlertViewControllerConfiguration *)configuration {
    self = [super init];
    
    if (self) {
        self.maximumWidth = 480.0f;

        _configuration = configuration;

        _alertBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        self.alertBackgroundView.clipsToBounds = YES;
        self.alertBackgroundView.layer.cornerRadius = configuration.alertViewCornerRadius;
        self.alertBackgroundView.backgroundColor = configuration.alertViewBackgroundColor;
        self.alertBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_alertBackgroundView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.font = configuration.titleFont;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = configuration.titleTextColor;
        self.titleLabel.text = NSLocalizedString(@"Title Label", nil);
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.alertBackgroundView addSubview:self.titleLabel];
        
        _messageTextView = [[NYAlertTextView alloc] initWithFrame:CGRectZero];
        self.messageTextView.backgroundColor = [UIColor clearColor];
        [self.messageTextView setContentHuggingPriority:0 forAxis:UILayoutConstraintAxisVertical];
        [self.messageTextView setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
        self.messageTextView.editable = NO;
        self.messageTextView.textAlignment = NSTextAlignmentCenter;
        self.messageTextView.textColor = configuration.messageTextColor;
        self.messageTextView.font = configuration.messageFont;
        self.messageTextView.text = NSLocalizedString(@"Message Text View", nil);
        self.messageTextView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.alertBackgroundView addSubview:self.messageTextView];
        
        _contentViewContainerView = [[UIView alloc] initWithFrame:CGRectZero];
        self.contentViewContainerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.alertBackgroundView addSubview:self.contentViewContainerView];
        
        _textFieldContainerView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.textFieldContainerView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        self.textFieldContainerView .translatesAutoresizingMaskIntoConstraints = NO;
        [self.alertBackgroundView addSubview:self.textFieldContainerView];
        
        _actionButtonContainerView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.actionButtonContainerView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        self.actionButtonContainerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.alertBackgroundView addSubview:self.actionButtonContainerView];

        _actionButtonStackView = [[UIStackView alloc] init];
        [self.actionButtonStackView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.actionButtonContainerView addSubview:self.actionButtonStackView];
        [self.actionButtonStackView ny_pinEdgesToSuperviewEdges];

        if (self.configuration.showsSeparators) {
            UIView *separatorView = [[UIView alloc] init];
            separatorView.backgroundColor = self.configuration.separatorColor;
            separatorView.translatesAutoresizingMaskIntoConstraints = NO;
            [self.alertBackgroundView addSubview:separatorView];
            [separatorView.heightAnchor constraintEqualToConstant:1.0f / [UIScreen mainScreen].scale].active = YES;
            [separatorView.leadingAnchor constraintEqualToAnchor:separatorView.superview.leadingAnchor].active = YES;
            [separatorView.trailingAnchor constraintEqualToAnchor:separatorView.superview.trailingAnchor].active = YES;
            [separatorView.bottomAnchor constraintEqualToAnchor:self.actionButtonStackView.topAnchor].active = YES;
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
        
        [self.alertBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_contentViewContainerView(0@250)]-[_titleLabel]-2-[_messageTextView][_textFieldContainerView(0@250)]-8-[_actionButtonContainerView]|"
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
        self.contentViewContainerView.layoutMargins = self.configuration.contentViewInset;
        [self.contentViewContainerView addSubview:self.contentView];
        [self.contentView ny_pinEdgesToSuperviewMargins];
    }
}

- (void)setTextFields:(NSArray *)textFields {
    for (UITextField *textField in self.textFields) {
        [textField removeFromSuperview];
    }
    
    _textFields = textFields;
    
    for (int i = 0; i < [textFields count]; i++) {
        UITextField *textField = textFields[i];
        textField.translatesAutoresizingMaskIntoConstraints = NO;
        [self.textFieldContainerView addSubview:textField];
        
        [self.textFieldContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[textField]-|"
                                                                                            options:0
                                                                                            metrics:nil
                                                                                              views:NSDictionaryOfVariableBindings(textField)]];
        
        // Pin the first text field to the top of the text field container view
        if (i == 0) {
            [textField.topAnchor constraintEqualToAnchor:self.textFieldContainerView.layoutMarginsGuide.topAnchor].active = YES;
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
    if (actionButtons.count == 2 && !self.configuration.alwaysArrangesActionButtonsVertically) {
        self.actionButtonStackView.axis = UILayoutConstraintAxisHorizontal;
    } else {
        self.actionButtonStackView.axis = UILayoutConstraintAxisVertical;
    }

    [actionButtons enumerateObjectsUsingBlock:^(UIButton *  _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.configuration.showsSeparators && idx > 0) {
            // Add separator view
            UIView *separatorView = [[UIView alloc] init];
            separatorView.backgroundColor = self.configuration.separatorColor;
            separatorView.translatesAutoresizingMaskIntoConstraints = NO;

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
