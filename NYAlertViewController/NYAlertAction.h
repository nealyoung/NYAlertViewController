//
//  NYAlertAction.h
//  NYAlertViewDemo
//
//  Created by Guillermo Saenz on 6/14/16.
//  Copyright © 2016 Nealon Young. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NYAlertAction : NSObject

+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(NYAlertAction *action))handler;

@property (weak, nonatomic) UIButton *actionButton;
@property (nonatomic) NSString *title;
@property (nonatomic) UIAlertActionStyle style;
@property (nonatomic, strong) void (^handler)(NYAlertAction *action);
@property (nonatomic) BOOL enabled;

@end
