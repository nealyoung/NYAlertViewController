#import <UIKit/UIKit.h>
#import "NYAlertActionConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@interface NYAlertAction : NSObject

+ (instancetype)actionWithTitle:(NSString *)title
                          style:(UIAlertActionStyle)style
                        handler:(void (^__nullable)(NYAlertAction *action))handler;

@property (nonatomic) NSString *title;
@property (nonatomic) UIAlertActionStyle style;
@property (nonatomic, strong, nullable) void (^handler)(NYAlertAction *action);
@property (nonatomic, strong, nullable) NYAlertActionConfiguration *configuration;
@property (nonatomic) BOOL enabled;

@end

// TODO: Move this to private header
@interface NYAlertAction ()

@property (weak, nonatomic) UIButton *actionButton;

@end

NS_ASSUME_NONNULL_END
