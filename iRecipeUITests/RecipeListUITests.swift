//
//  RecipeListUITests.swift
//  iRecipe
//
//  Created by Meng Li on 09/02/2026.
//

import XCTest

final class RecipeListUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launchArguments.append("-ui-testing")
        app.launch()
    }

    func test_recipeList_showsRecipes() {
        let list = app.tables["recipe_list"]
        XCTAssertTrue(list.waitForExistence(timeout: 2))

        let firstCell = app.otherElements["recipe_cell_1"]
        XCTAssertTrue(firstCell.exists)
    }

    func test_search_filtersRecipes() {
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.exists)

        searchField.tap()
        searchField.typeText("Vege")

        let cell1 = app.otherElements["recipe_cell_1"]
        XCTAssertTrue(cell1.waitForExistence(timeout: 2))

        let cell2 = app.otherElements["recipe_cell_2"]
        XCTAssertFalse(cell2.exists)
    }
}
