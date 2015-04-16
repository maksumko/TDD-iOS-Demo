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
    
    _info = [[RegistrationInfo alloc]init];
}

- (IBAction)tapRegister:(id)sender {
    NSString* validationResult = [_info validate];
    
    if(validationResult == nil) {
        _usernameField.text = nil;
        _passwordField.text = nil;
        _emailField.text = nil;
    } else {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:validationResult delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if([textField isEqual:_usernameField]) {
        _info.username = textField.text;
    }
    
    if([textField isEqual:_emailField]) {
        _info.email = textField.text;
    }
    if([textField isEqual:_passwordField]) {
        _info.password = textField.text;
    }
}

@end
