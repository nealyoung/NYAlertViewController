//
//  NYAlertAction.h
//  HackerFeed
//
//  Created by Nealon Young on 7/13/15.
//  Copyright (c) 2015 Nealon Young. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NYAlertAction : NSObject

+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(NYAlertAction *action))handler;

@property (nonatomic) NSString *title;
@property (nonatomic) UIAlertActionStyle style;
@property (nonatomic, strong) void (^handler)(NYAlertAction *action);

@end
