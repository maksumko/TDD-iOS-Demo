//
//  RegistrationScreen.m
//  RegistrationFlow
//
//  Created by maxim.k on 4/16/15.
//  Copyright (c) 2015 maxim.k. All rights reserved.
//

#import "RegistrationScreen.h"
#import "RegistrationInfo.h"


@implementation RegistrationScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self resetRegistrationInfo];
}

- (IBAction)tapRegister:(id)sender {
    NSString* validationResult = [_info validate];
    
    if(validationResult == nil) {
        _usernameField.text = nil;
        _passwordField.text = nil;
        _emailField.text = nil;
        
        [self resetRegistrationInfo];
    } else {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:validationResult delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)resetRegistrationInfo {
    _info = [RegistrationInfo new];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if(textField == _usernameField) {
        _info.username = textField.text;
    } else if(textField == _emailField) {
        _info.email = textField.text;
    } else if(textField == _passwordField) {
        _info.password = textField.text;
    }
}

@end
