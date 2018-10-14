//
//  NYAlertAction.m
//  NYAlertViewDemo
//
//  Created by Guillermo Saenz on 6/14/16.
//  Copyright © 2016 Nealon Young. All rights reserved.
//

#import "NYAlertAction.h"

@implementation NYAlertAction

+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(NYAlertAction *action))handler {
    NYAlertAction *action = [[NYAlertAction alloc] init];
    action.title = title;
    action.style = style;
    action.handler = handler;
    
    return action;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _enabled = YES;
    }
    
    return self;
}

- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    
    self.actionButton.enabled = enabled;
}

@end
