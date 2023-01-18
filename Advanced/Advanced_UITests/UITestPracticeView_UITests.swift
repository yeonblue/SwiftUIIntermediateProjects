//
//  UITestPracticeView_UITests.swift
//  Advanced_UITests
//
//  Created by yeonBlue on 2023/01/18.
//

import XCTest
@testable import Advanced
import Combine

// Naming:
// test로 반드시 시작
// test_UnitOfWork_StateUnderTest_ExpectedBehavior
// test_[struct or class]_[ui_components]_[expected result]
// Gien, When, Then
// user flow를 테스트

final class UITestPracticeView_UITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        // app.launchArguments = ["-UITest_startSignIn"] // edit scheme에 추가한 parameter를 추가도 가능
        // app.launchEnvironment = ["-UITest_startSignIn" : "true"]
        app.launch()
    }

    override func tearDownWithError() throws {

    }

    func test_UITestPracticeView_signupButton_shouldNotSignin() {
        
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: false)
        
        // When
        let navBar = app.navigationBars["Welcome"]
        
        // Then
        XCTAssertFalse(navBar.exists)
    }
    
    func test_UITestPracticeView_signupButton_shouldSignin() {
        
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: true)
        
        // When
        let navBar = app.navigationBars["Welcome"]
        
        // Then
        XCTAssertTrue(navBar.exists)
    }

    func test_SignInHomeView_showAlertButton_shouldDisplayAlert() {
        
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: true)
        
        // When
        tapAlertButton(shouldDismissAlert: false)

        // Then
        let alert = app.alerts.firstMatch // alert는 한 개만 존재가능하므로
        XCTAssertFalse(alert.exists)
    }
    
    func test_SignInHomeView_showAlertButton_shouldDisplayAndDismissAlert() {
        
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: true)
        
        // When
        tapAlertButton(shouldDismissAlert: true)
        
        // Then
        let alert = app.alerts.firstMatch // alert는 한 개만 존재가능하므로
        XCTAssertFalse(alert.exists)
    }
        
    func test_SignInHomeView_NavigationLinkToDestination_shouldNavigateToDestination() {
        
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: true)
                        
        // When
        tapNavigationLink(shouldDismissDestination: false)

        // Then
        let destinationText = app.staticTexts["Destination"]
        XCTAssertTrue(destinationText.exists)
    }
    
    func test_SignInHomeView_NavigationLinkToDestination_shouldNavigateToDestinationAndGoBack() {
        
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: true)
        
        // When
        tapNavigationLink(shouldDismissDestination: true)
        
        // Then
        let navBar = app.navigationBars["Welcome"]
        XCTAssertTrue(navBar.exists)
    }
}

// MARK: - Functions
extension UITestPracticeView_UITests {
    
    func signUpAndSignIn(shouldTypeOnKeyboard: Bool) {
        
        let textField = app.textFields["SignUpTextField"] // accessibilityIdentifier 추가
        textField.tap()

        if shouldTypeOnKeyboard {
            let keyA = app.keys["A"]
            keyA.tap()
            
            let keyLowerA = app.keys["a"]
            keyLowerA.tap()
            keyLowerA.tap()
            
            let returnButton = app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
            returnButton.tap()
        }
        
        let signUpButton = app.buttons["SignUp"]
        signUpButton.tap()
    }
    
    func tapAlertButton(shouldDismissAlert: Bool) {
        let showAlertButton = app.buttons["ShowAlertButton"]
        showAlertButton.tap()
        
        if shouldDismissAlert {
            let alert = app.alerts.firstMatch // alert는 한 개만 존재가능하므로
            XCTAssertTrue(alert.exists)
           
            let alertOkButton = alert.buttons["OK"]
            let alertExists = alert.waitForExistence(timeout: 3)
            XCTAssertTrue(alertExists)
            alertOkButton.tap()
        }
    }
    
    func tapNavigationLink(shouldDismissDestination: Bool) {
        let navLink = app.buttons["NavigationLinkDestination"]
        navLink.tap()
        
        if shouldDismissDestination {
            let destinationText = app.staticTexts["Destination"]
            XCTAssertTrue(destinationText.exists)
            
            let backButton = app.navigationBars.buttons["Welcome"]
            backButton.tap()
        }
    }
}
