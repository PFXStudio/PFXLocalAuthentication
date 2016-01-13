//
//  PFXLocalAuthentication.h
//  PFXLocalAuthentication
//
//  Created by succorer on 2016. 1. 13..
//  Copyright © 2016년 succorer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFXLocalAuthentication : NSObject

+ (void)canLocalAuthenticationWithCompletion:(void(^)(void))completion failure:(void(^)(NSError *error))failure;
+ (void)evaluateLocalAuthenticationWithCompletion:(void(^)(void))completion failure:(void(^)(NSError *error))failure;


@end
