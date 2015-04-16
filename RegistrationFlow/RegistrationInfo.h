//
//  RegistrationInfo.h
//  RegistrationFlow
//
//  Created by maxim.k on 4/16/15.
//  Copyright (c) 2015 maxim.k. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegistrationInfo : NSObject

@property (nonatomic, copy) NSString* username;
@property (nonatomic, copy) NSString* email;
@property (nonatomic, copy) NSString* password;

- (NSString *)validate;

@end
