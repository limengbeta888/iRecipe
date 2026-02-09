//
//  RecipeDetailUITests.swift
//  iRecipe
//
//  Created by Meng Li on 09/02/2026.
//

import XCTest

final class RecipeDetailUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launchArguments.append("-ui-testing")
        app.launch()
    }

    func test_tapRecipe_opensDetail() {
        let cell = app.otherElements["recipe_cell_1"]
        XCTAssertTrue(cell.waitForExistence(timeout: 2))

        cell.tap()

        let title = app.staticTexts["recipe_detail_title"]
        XCTAssertTrue(title.waitForExistence(timeout: 2))
        XCTAssertEqual(title.label, "Pasta Carbonara")
    }

    func test_shareButton_opensShareSheet() {
        app.otherElements["recipe_cell_1"].tap()

        let shareButton = app.buttons["share_button"]
        XCTAssertTrue(shareButton.exists)

        shareButton.tap()

        let sheet = app.sheets.firstMatch
        XCTAssertTrue(sheet.waitForExistence(timeout: 2))
    }
}
