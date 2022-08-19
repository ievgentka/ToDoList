//
//  XCUIElement+Action.swift
//  ToDoListUITests
//
//  Created by Eugene Tkachenko on 18.08.2022.
//  Copyright © 2022 Radu Ursache - RanduSoft. All rights reserved.
//

import XCTest

extension XCUIElement {
    public func clearAndTypeText(text: String) {
        self.tap()
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to write String into non String value.")
            return
        }
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        typeText(deleteString + text)
    }
}
