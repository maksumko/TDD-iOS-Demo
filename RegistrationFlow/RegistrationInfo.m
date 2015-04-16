//
//  RegistrationInfo.m
//  RegistrationFlow
//
//  Created by maxim.k on 4/16/15.
//  Copyright (c) 2015 maxim.k. All rights reserved.
//

#import "RegistrationInfo.h"

@implementation RegistrationInfo

- (NSString *)validate {
    
    NSString* result;
    
    
    result = [self validateUsername];
    
    if(result)
        return result;
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    result = ([predicate evaluateWithObject:_email] ? nil : @"Incorrect email");
    
    if(result)
        return result;
    
     result = (([_password length] >= 16) ? nil : @"Password should consist at least of 16 characters");
    
    if(result)
        return result;
    
    return nil;
}

- (NSString *)validateUsername {
    NSCharacterSet *unwantedCharacters = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    NSRange range = [_username rangeOfCharacterFromSet:unwantedCharacters];
    
    return (range.location == NSNotFound ? nil : @"Invalid username");
}

@end
