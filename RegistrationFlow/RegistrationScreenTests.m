//
//  RegistrationScreenTests.m
//  RegistrationFlow
//
//  Created by maxim.k on 4/16/15.
//  Copyright (c) 2015 maxim.k. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RegistrationScreen.h"
#import "OCMock.h"
#import "RegistrationInfo.h"


@interface RegistrationScreenTests : XCTestCase {
    RegistrationScreen* _sut;
}

@end

@implementation RegistrationScreenTests

- (void)setUp {
    [super setUp];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _sut = [storyboard instantiateViewControllerWithIdentifier:@"registration"];
}

- (void)tearDown {
    _sut = nil;
    [super tearDown];
}

- (void)testScreenExists {
    XCTAssertNotNil(_sut);
}

- (void)testControllerInstantiatesWithCorrectClass {
    XCTAssertTrue([_sut isKindOfClass:[RegistrationScreen class]]);
}

- (void)testOutlets {
    [_sut view];
    
    XCTAssertNotNil(_sut.usernameField);
    XCTAssertNotNil(_sut.emailField);
    XCTAssertNotNil(_sut.passwordField);
    
    XCTAssertNotNil(_sut.registerButton);
}

- (void)testCallsActionOnTap {
    [_sut view];
    
    XCTAssertTrue([[_sut.registerButton actionsForTarget:_sut forControlEvent:UIControlEventTouchUpInside] containsObject:NSStringFromSelector(@selector(tapRegister:))]);
}

- (void)testFieldsDelegates {
    [_sut view];
    
    XCTAssertTrue([_sut.usernameField.delegate isEqual:_sut]);
    XCTAssertTrue([_sut.emailField.delegate isEqual:_sut]);
    XCTAssertTrue([_sut.passwordField.delegate isEqual:_sut]);
}

- (void)testSetUsername {
    [_sut viewDidLoad];
    NSString* username = @"qwe";
    id mockField = [OCMockObject mockForClass:[UITextField class]];
    [[[mockField stub] andReturn:username] text];
    _sut.usernameField = mockField;
    
    [_sut textFieldDidEndEditing:mockField];
    
    XCTAssertEqualObjects(username, _sut.info.username);
}

- (void)testSetPassword {
    [_sut viewDidLoad];
    NSString* result = @"qwe";
    id mockField = [OCMockObject mockForClass:[UITextField class]];
    [[[mockField stub] andReturn:result] text];
    _sut.passwordField = mockField;
    
    [_sut textFieldDidEndEditing:mockField];
    
    XCTAssertEqualObjects(result, _sut.info.password);
}

- (void)testSetEmail {
    [_sut viewDidLoad];
    NSString* result = @"qwe";
    id mockField = [OCMockObject mockForClass:[UITextField class]];
    [[[mockField stub] andReturn:result] text];
    _sut.emailField = mockField;
    
    [_sut textFieldDidEndEditing:mockField];
    
    XCTAssertEqualObjects(result, _sut.info.email);
}

- (void)testSuccesedValidation {
    [_sut view];
    id mockInfo = OCMClassMock([RegistrationInfo class]);
    [[[mockInfo stub] andReturn:nil] validate];
    
    
    _sut.usernameField.text = @"1";
    _sut.emailField.text = @"1";
    _sut.passwordField.text = @"1";
    
    _sut.info = mockInfo;
    
    [_sut tapRegister:nil];
    
    XCTAssertTrue([_sut.usernameField.text length] == 0);
    XCTAssertTrue([_sut.passwordField.text length] == 0);
    XCTAssertTrue([_sut.emailField.text length] == 0);
}

- (void)testFailValidation {
    [_sut view];
    id mockInfo = OCMClassMock([RegistrationInfo class]);
    [[[mockInfo stub] andReturn:@"qwe"] validate];
    
    id mockAlert = OCMClassMock([UIAlertView class]);
    [[[mockAlert stub] andReturn:mockAlert] alloc];
    
    (void)[[[mockAlert stub] andReturn:mockAlert] initWithTitle:OCMOCK_ANY message:OCMOCK_ANY delegate:OCMOCK_ANY cancelButtonTitle:OCMOCK_ANY otherButtonTitles:OCMOCK_ANY,nil];
    
    [[mockAlert expect] show];
    
    _sut.info = mockInfo;
    
    [_sut tapRegister:nil];
    

    [mockAlert verify];
}

- (void)testFailValidationShowCorrectMessage {
    [_sut view];
    NSString* message = @"msg";
    id mockInfo = OCMClassMock([RegistrationInfo class]);
    [[[mockInfo stub] andReturn:message] validate];
    
    id mockAlert = OCMClassMock([UIAlertView class]);
    [[[mockAlert stub] andReturn:mockAlert] alloc];
    
    (void)[[[mockAlert stub] andReturn:mockAlert] initWithTitle:OCMOCK_ANY message:message delegate:OCMOCK_ANY cancelButtonTitle:OCMOCK_ANY otherButtonTitles:OCMOCK_ANY,nil];
    
    [[mockAlert expect] show];
    
    _sut.info = mockInfo;
    
    [_sut tapRegister:nil];
    
    
    [mockAlert verify];
}

@end
