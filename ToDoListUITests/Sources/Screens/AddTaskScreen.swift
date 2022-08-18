//
//  AddTaskScreen.swift
//  ToDoListUITests
//
//  Created by Eugene Tkachenko on 18.08.2022.
//  Copyright © 2022 Radu Ursache - RanduSoft. All rights reserved.
//

import XCTest

public class AddTaskScreen {
    private let addTaskNavigationBar = XCUIApplication().navigationBars["Add task"].firstMatch
    public func waitToExist() {
        _ = addTaskNavigationBar.waitToExist()
    }
    
    @discardableResult
    public func addTaskContent(_ content: String) -> Self {
        let taskContentField = XCUIApplication().textViews["task_title_text_view"]
        taskContentField.typeText(content)
        return self
    }
    
    public func saveTask() {
        let saveTaskButton = addTaskNavigationBar.buttons["add_task_save_button"]
        saveTaskButton.tap()
        waitForElement(addTaskNavigationBar, toExist: false)
    }
 
    @discardableResult
    public func setDate(
        day: String? = nil,
        hour: String? = nil,
        minutes: String? = nil,
        timePeriod: String? = nil
    ) -> Self {
        let dateButton = XCUIApplication().buttons["date_button"]
        dateButton.tap()
        
        let datePicker = XCUIApplication().datePickers.firstMatch
        waitForElement(datePicker, toExist: true)
        
        if day != nil {
            datePicker.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: day!)
        }
        if hour != nil {
            datePicker.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: hour!)
        }
        if minutes != nil {
            datePicker.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: minutes!)
        }
        if timePeriod != nil {
            datePicker.pickerWheels.element(boundBy: 3).adjust(toPickerWheelValue: timePeriod!)
        }

        let saveDateButton = XCUIApplication().toolbars["Toolbar"].buttons["Save"]
        saveDateButton.tap()
        waitForElement(datePicker, toExist: false)
        
        return self
    }
}
