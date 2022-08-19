//
//  XCUIElement+Wait.swift
//  ToDoListUITests
//
//  Created by Eugene Tkachenko on 18.08.2022.
//  Copyright © 2022 Radu Ursache - RanduSoft. All rights reserved.
//

import XCTest



extension XCUIElement {
    public func waitToExist() -> XCUIElement {
        waitForElement(self)
        return self
    }
    
    public func waitToBeHittable() -> XCUIElement {
        waitForHittable(self)
        return self
    }
}
