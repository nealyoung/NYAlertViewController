#import <UIKit/UIKit.h>
#import "NYAlertViewControllerConfiguration.h"

@interface NYAlertView : UIView

@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UITextView *messageTextView;
@property (nonatomic) UIView *contentView;

@property (nonatomic) CGFloat maximumWidth;

@property (nonatomic, readonly) NSLayoutConstraint *backgroundViewVerticalCenteringConstraint;

@property (nonatomic) NSArray *actionButtons;
@property (nonatomic) NSArray *textFields;

- (instancetype)initWithConfiguration:(NYAlertViewControllerConfiguration *)configuration;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end
