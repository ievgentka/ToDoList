//
//  MainScreen.swift
//  ToDoListUITests
//
//  Created by Eugene Tkachenko on 18.08.2022.
//  Copyright © 2022 Radu Ursache - RanduSoft. All rights reserved.
//

import Foundation
import XCTest

public class HomeScreen {
    
    public func waitToExist() {
        _ = XCUIApplication().windows.tables["home_screen"].waitToExist()
    }
    
    public var addTask: AddTaskScreen {
        let addTaskButton = XCUIApplication().windows.buttons["add_task_button"].firstMatch
        addTaskButton.tap()
        let addTaskScreen = AddTaskScreen()
        return addTaskScreen
    }
    
    public func openTaskList(screen: HomeScreenItems) -> TasksListScreen {
        let homeScreenItem = screen.homeScreenItem //homeScreenTable.cells[homeScreenCellID]
        homeScreenItem.tap()
        // TODO: Refactor this part when need to create tests "Custom Interval validation"
        if screen == .custom {
            XCUIApplication().buttons["Done"].tap()
        }
        let tasksListScreen = TasksListScreen()
        tasksListScreen.waitForOpen()
        
        return TasksListScreen()
    }
    
    public func tasksQuantityInside(section: HomeScreenItems) -> String {
        let quantity = section.tasksQuantity.label
        return quantity
    } 
}

public enum HomeScreenItems: String {
    case all
    case today
    case tomorrow
    case week
    case custom
    case completed
    
    fileprivate var tasksQuantity: XCUIElement {
        switch self {
        case .all, .today, .tomorrow, .week, .custom, .completed:
            let tasksQuantity = XCUIApplication().staticTexts["\(self.rawValue)_number"]
            return tasksQuantity
        }
    }
    
    private var homeScreenCellID: String {
        switch self {
        case .all, .today, .tomorrow, .week, .custom, .completed:
            return "\(self.rawValue)_cell"
        }
    }
    
    fileprivate var homeScreenItem: XCUIElement {
        XCUIApplication().windows.tables["home_screen"].cells[homeScreenCellID]
    }
}
