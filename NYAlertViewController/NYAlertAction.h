#import <UIKit/UIKit.h>
#import "NYAlertActionConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@interface NYAlertAction : NSObject

- (instancetype)initWithTitle:(NSString *)title
                        style:(UIAlertActionStyle)style
                      handler:(void (^__nullable)(NYAlertAction *action))handler;

- (instancetype)initWithTitle:(NSString *)title
                        style:(UIAlertActionStyle)style
                      handler:(void (^__nullable)(NYAlertAction *action))handler
                configuration:(nullable NYAlertActionConfiguration *)configuration;

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, readonly) UIAlertActionStyle style;
@property (nonatomic, strong, readonly, nullable) void (^handler)(NYAlertAction *action);
@property (nonatomic, strong, readonly, nullable) NYAlertActionConfiguration *configuration;
@property (nonatomic) BOOL enabled;

@end

NS_ASSUME_NONNULL_END
