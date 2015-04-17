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

- (UITextField *)mockTextField {
    id mockField = [OCMockObject mockForClass:[UITextField class]];
    [[[mockField stub] andReturn:@"some text"] text];
    
    return mockField;
}

- (void)testSetUsername {
    [_sut viewDidLoad];
    _sut.usernameField = [self mockTextField];
    
    [_sut textFieldDidEndEditing:_sut.usernameField];
    
    XCTAssertEqualObjects(_sut.usernameField.text, _sut.info.username);
}

- (void)testSetPassword {
    [_sut viewDidLoad];
    _sut.passwordField = [self mockTextField];
    
    [_sut textFieldDidEndEditing:_sut.passwordField];
    
    XCTAssertEqualObjects(_sut.passwordField.text, _sut.info.password);
}

- (void)testSetEmail {
    [_sut viewDidLoad];
    _sut.emailField = [self mockTextField];
    
    [_sut textFieldDidEndEditing:_sut.emailField];
    
    XCTAssertEqualObjects(_sut.emailField.text, _sut.info.email);
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

- (void)testResetInfoAfterSuccesValidation {
    // ARRANGE
    id mockRegInfo = OCMClassMock([RegistrationInfo class]);
    [[[mockRegInfo stub] andReturn:nil] validate];
    _sut.info = mockRegInfo;
    
    // ACT
    [_sut tapRegister:nil];
    
    // ASSERT
    XCTAssertNotEqualObjects(_sut.info, mockRegInfo);
}

- (void)testDoNotShowAlertOnRegisterTapIfInfoIsValid {
    // ARRANGE
    id mockRegInfo = OCMClassMock([RegistrationInfo class]);
    [[[mockRegInfo stub] andReturn:nil] validate];
    _sut.info = mockRegInfo;
    
    id mockAlert = OCMClassMock([UIAlertView class]);
    [[mockAlert reject] alloc];
    
    // ACT
    [_sut tapRegister:nil];
    
    // ASSERT
    [mockAlert verify];
    [mockAlert stopMocking];
}

- (void)testControllerHidesKeyboardOnReturn {
    // ARRANGE
    id fieldMock = OCMClassMock([UITextField class]);
    [[fieldMock expect] resignFirstResponder];
    
    // ACT
    [_sut textFieldShouldReturn:fieldMock];
    
    // ASSERT
    [fieldMock verify];
}

@end
