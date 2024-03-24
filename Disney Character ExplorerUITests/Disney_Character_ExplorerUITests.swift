//
//  Disney_Character_ExplorerUITests.swift
//  Disney Character ExplorerUITests
//
//  Created by Emil Vaklinov on 20/03/2024.
//

import XCTest

final class Disney_Character_ExplorerUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Perform any teardown required here
    }
    
    func testAddingCharacterToFavorites() throws {
        let app = XCUIApplication()
        
        //'Search Characters' is the placeholder text for the search bar
        let searchField = app.textFields["Search Characters"]
        XCTAssertTrue(searchField.exists, "Search field doesn't exist")
        searchField.tap()
        searchField.typeText("Achilles")

        let characterCell = app.buttons["Achilles, 🎬: 1, 🎮: 1, 📺: 1, 🎢: 0"]
        XCTAssertTrue(characterCell.waitForExistence(timeout: 5), "Character cell doesn't exist")
        characterCell.tap()

        // Interact with the "Add or Remove to Favorites" button
        let addToFavoritesButton = app.buttons["Add to Favorites"]
        let removeFromFavoritesButton = app.buttons["Remove from Favorites"]

        if addToFavoritesButton.exists {
            XCTAssertTrue(addToFavoritesButton.exists, "Add to Favorites button doesn't exist")
            addToFavoritesButton.tap()
            XCTAssertTrue(removeFromFavoritesButton.exists, "Remove from Favorites button should exist after tapping 'Add to Favorites'")
        } else if removeFromFavoritesButton.exists {
            XCTAssertTrue(removeFromFavoritesButton.exists, "Remove from Favorites button doesn't exist")
            removeFromFavoritesButton.tap()
            XCTAssertTrue(addToFavoritesButton.exists, "Add to Favorites button should exist after tapping 'Remove from Favorites'")
        } else {
            XCTFail("Neither 'Add to Favorites' nor 'Remove from Favorites' button exists")
        }
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
