#import <UIKit/UIKit.h>

@interface NYAlertAction : NSObject

+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(NYAlertAction *action))handler;

@property (nonatomic) NSString *title;
@property (nonatomic) UIAlertActionStyle style;
@property (nonatomic, strong) void (^handler)(NYAlertAction *action);
@property (nonatomic) BOOL enabled;

@end

// TODO: Move this to private header
@interface NYAlertAction ()

@property (weak, nonatomic) UIButton *actionButton;

@end
