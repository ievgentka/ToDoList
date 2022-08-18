//
//  EditTaskScreen.swift
//  ToDoListUITests
//
//  Created by Eugene Tkachenko on 18.08.2022.
//  Copyright © 2022 Radu Ursache - RanduSoft. All rights reserved.
//

import XCTest

public class EditTaskScreen {
    private let editTaskNavigationBar = XCUIApplication().navigationBars["Edit task"].firstMatch
    
    public func waitToExist() {
        _ = editTaskNavigationBar.waitToExist()
    }
    
    @discardableResult
    public func addTaskContent(_ content: String) -> Self {
        let taskContentField = XCUIApplication().textViews["task_title_text_view"]
        taskContentField.typeText(content)
        return self
    }
    
    public func clearAndAddTaskContent(_ content: String) -> Self {
        let taskContentField = XCUIApplication().textViews["task_title_text_view"]
        taskContentField.clearAndTypeText(text: content)
        return self
    }
    
    public func saveTask() {
        let saveTaskButton = editTaskNavigationBar.buttons["add_task_save_button"]
        saveTaskButton.tap()
        waitForElement(editTaskNavigationBar, toExist: false)
    }
}
