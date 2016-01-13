//
//  PFXLocalAuthentication.m
//  PFXLocalAuthentication
//
//  Created by succorer on 2016. 1. 13..
//  Copyright © 2016년 succorer. All rights reserved.
//

#import <LocalAuthentication/LocalAuthentication.h>
#import "PFXLocalAuthentication.h"

@implementation PFXLocalAuthentication

+ (void)canLocalAuthenticationWithCompletion:(void(^)(void))completion failure:(void(^)(NSError *error))failure
{
    LAContext *context = [LAContext new];
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil] == NO)
    {
        if (failure == nil)
        {
            return;
        }
        
        NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"%s %d", __func__, __LINE__] code:-100 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Fingerprint authentication disavailable.", @"comment", nil]];
        failure(error);
        return;
    }

    if (completion == nil)
    {
        return;
    }
    
    completion();
}

+ (void)evaluateLocalAuthenticationWithCompletion:(void(^)(void))completion failure:(void(^)(NSError *error))failure
{
    LAContext *context = [LAContext new];
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Fingerprint authentication" reply:^(BOOL success, NSError * _Nullable error) {
        if (error != nil)
        {
            NSLog(@"Error Fingerprint authentication %@", error);
            if (failure == nil)
            {
                return;
            }
            
            failure(error);
            return;
        }
        
        if (success == NO)
        {
            if (failure == nil)
            {
                return;
            }
            
            NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"%s %d", __func__, __LINE__] code:-101 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Fail Fingerprint authentication", @"comment", nil]];
            failure(error);
            return;
        }
        
        if (completion == nil)
        {
            return;
        }
        
        completion();
    }];
}

@end
