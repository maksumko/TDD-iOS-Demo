//
//  RegistrationScreen.h
//  RegistrationFlow
//
//  Created by maxim.k on 4/16/15.
//  Copyright (c) 2015 maxim.k. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegistrationInfo;

@interface RegistrationScreen : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField* usernameField;
@property (nonatomic, weak) IBOutlet UITextField* emailField;
@property (nonatomic, weak) IBOutlet UITextField* passwordField;

@property (nonatomic, weak) IBOutlet UIButton* registerButton;

@property (nonatomic, strong) RegistrationInfo* info;

- (IBAction)tapRegister:(id)sender;


@end
