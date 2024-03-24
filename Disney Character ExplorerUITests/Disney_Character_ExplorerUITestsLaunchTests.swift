//
//  Disney_Character_ExplorerUITestsLaunchTests.swift
//  Disney Character ExplorerUITests
//
//  Created by Emil Vaklinov on 20/03/2024.
//

import XCTest
@testable import Disney_Character_Explorer
import SwiftUI

final class Disney_Character_ExplorerUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app
        app.textFields["Search Characters"].tap()
        app.collectionViews.buttons["Achilles, 🎬: 1, 🎮: 1, 📺: 1, 🎢: 0"].tap()        
        app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Characters"].tap()
        app/*@START_MENU_TOKEN@*/.images["Filter"]/*[[".buttons[\"Filter\"]",".buttons.images[\"Filter\"]",".images[\"Filter\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
