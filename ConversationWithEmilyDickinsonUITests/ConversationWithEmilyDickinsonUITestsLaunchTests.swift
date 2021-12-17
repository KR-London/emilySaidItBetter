//
//  ConversationWithEmilyDickinsonUITestsLaunchTests.swift
//  ConversationWithEmilyDickinsonUITests
//
//  Created by Kate Roberts on 09/10/2021.
//

import XCTest

class ConversationWithEmilyDickinsonUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        let timeTraveler = TimeTraveler()
        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}


class TimeTraveler {
    private var date = Date()
    
    func travel(by timeInterval: TimeInterval) {
        date = date.addingTimeInterval(timeInterval)
    }
    
    func generateDate() -> Date {
        return date
    }
}
