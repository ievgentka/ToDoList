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
    
    public func cancelTaskCreation() {
        let cancelTaskCreationButton = addTaskNavigationBar.buttons["add_task_cencel_button"]
        cancelTaskCreationButton.tap()
        waitForElement(addTaskNavigationBar, toExist: false)
    }
    
    public func saveEmptyTask() -> Bool {
        let saveTaskButton = addTaskNavigationBar.buttons["add_task_save_button"]
        saveTaskButton.tap()
        let alert = XCUIApplication().alerts["Error"].firstMatch
        let isExist = alert.exists
        alert.buttons["OK"].tap()
        waitForElement(alert, toExist: false)
        return isExist
    }
    
    @discardableResult
    public func setDate(
        day: TasksDate = .today,
        hour: String? = nil,
        minutes: String? = nil,
        timePeriod: String? = nil
    ) -> Self {
        let dateButton = XCUIApplication().buttons["date_button"]
        dateButton.tap()
        
        let datePicker = XCUIApplication().datePickers.firstMatch
        waitForElement(datePicker, toExist: true)

        datePicker.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: day.day())

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

public enum TasksDate: String {
    case today
    case tomorrow
    case afterTwoDays
    case afterSevenDays
    case afterEightDays
    
    public func day(withFormat: String = "MMM dd") -> String {
        switch self {
        case .today:
            return increaseCurrentDateBy(days: 0, withFormat: withFormat)
        case .tomorrow:
            return increaseCurrentDateBy(days: 1, withFormat: withFormat)
        case .afterTwoDays:
            return increaseCurrentDateBy(days: 2, withFormat: withFormat)
        case .afterSevenDays:
            return increaseCurrentDateBy(days: 7, withFormat: withFormat)
        case .afterEightDays:
            return increaseCurrentDateBy(days: 8, withFormat: withFormat)
        }
    }
    
    private func increaseCurrentDateBy(days: Double, withFormat: String) -> String {
        let date = Date().addingTimeInterval(days*24*60*60).formatted().components(separatedBy: ",")
        let day = date[0]
        let formattedDay = CommonHelpers().formattedDateFromString(dateString: day, withFormat: withFormat)!
        
        return formattedDay
    }
}
