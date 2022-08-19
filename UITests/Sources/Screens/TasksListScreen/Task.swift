//
//  Task.swift
//  ToDoListUITests
//
//  Created by Eugene Tkachenko on 18.08.2022.
//  Copyright © 2022 Radu Ursache - RanduSoft. All rights reserved.
//

import XCTest

public class Task {
    private let element: XCUIElement
    
    init(element: XCUIElement) {
        self.element = element
    }
    
    public var exists: Bool {
        element.exists
    }
    
    public var delete: TasksListScreen {
        element.swipeLeft()
        element.buttons["Delete"].tap()
        return TasksListScreen()
    }
    
    public var select: TaskOptions {
        element.tap()
        let taskOptions = TaskOptions()
        taskOptions.waitForOpen()
        return taskOptions
    }
    
    public var content: String { element.staticTexts.firstMatch.label }
}
