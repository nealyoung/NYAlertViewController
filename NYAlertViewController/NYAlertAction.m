//
//  NYAlertAction.m
//
//  Created by Nealon Young on 7/13/15.
//  Copyright (c) 2015 Nealon Young. All rights reserved.
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
@end
