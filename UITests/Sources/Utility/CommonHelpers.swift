//
//  CommonHelpers.swift
//  ToDoListUITests
//
//  Created by Eugene Tkachenko on 18.08.2022.
//  Copyright © 2022 Radu Ursache - RanduSoft. All rights reserved.
//

import XCTest


public class CommonHelpers {
    
    public static func randomString(charset: SymbolsList, length: Int) -> String {
        let letters = charset.rawValue
        var str = ""
        for _ in 0 ..< length {
            str.append(letters.randomElement()!)
        }
        return str
    }
    
    public enum SymbolsList: String {
        case english = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 !@#$%^&* ()?/[]{}~+-"
        case сyrillic = "йцукенгшщзхїґфивапролджєюбьтімсчя !@#$%^&* ()?/[]{}~+-"
    }
}

public func waitForElement(
    _ element: XCUIElement,
    toExist: Bool = true,
    timeOut: Double = 30,
    assertMessage: String? = nil,
    elementName: String? = nil
) {
    let predicate = NSPredicate(format: "exists == \(toExist)")
    let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
    
    waitForPredicate(
        expectation,
        timeOut: timeOut,
        elementName: elementName ?? "\(element)",
        condition: toExist ? "to exist" : "to not exist",
        assertMessage: assertMessage
    )
}

public func waitForHittable(
    _ element: XCUIElement,
    hittable: Bool = true,
    timeOut: Double = 30,
    elementName: String? = nil
) {
    let predicate = NSPredicate(format: "hittable == \(hittable)")
    let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
    
    waitForPredicate(
        expectation,
        timeOut: timeOut,
        elementName: elementName ?? "\(element)",
        condition: hittable ? "to be hittable" : "to not be hittable"
    )
}

public func waitForCount(
    _ query: XCUIElementQuery,
    count: Int,
    timeOut: Double = 30,
    assertMessage: String? = nil,
    elementName: String? = nil
) {
    let predicate = NSPredicate(format: "count == \(count)")
    let expectation = XCTNSPredicateExpectation(predicate: predicate, object: query)
    
    waitForPredicate(
        expectation,
        timeOut: timeOut,
        elementName: elementName ?? "\(query)",
        condition: "count to be \(count)",
        assertMessage: assertMessage
    )
}

private func waitForPredicate(
    _ expectation: XCTNSPredicateExpectation,
    timeOut: Double,
    elementName: String,
    condition: String,
    assertMessage: String? = nil
) {
    let result = XCTWaiter().wait(for: [expectation], timeout: timeOut)
    XCTAssertTrue(
        result == .completed,
        assertMessage ?? "Wait for element `\(elementName)` \(condition) timed out after \(timeOut) seconds."
    )
}


