//
//  TasksListScreen.swift
//  ToDoListUITests
//
//  Created by Eugene Tkachenko on 18.08.2022.
//  Copyright © 2022 Radu Ursache - RanduSoft. All rights reserved.
//

import XCTest

public class TasksListScreen {
    private let addTaskButton = XCUIApplication().buttons["item_add_task_button"]
    private var tasksCells = XCUIApplication().cells.matching(identifier: "task_list_cell")
    
    public func waitForOpen() {
        _ = addTaskButton.waitToExist()
    }
    
    public var addTask: AddTaskScreen {
        addTaskButton.tap()
        let addTaskScreen = AddTaskScreen()
        return addTaskScreen
    }
    
    public var openHomeScreen: HomeScreen {
        let backButton = XCUIApplication().navigationBars.buttons["Back"]
        backButton.tap()
        let homeScreen = HomeScreen()
        homeScreen.waitToExist()
        return homeScreen
    }
    
    public var countTasks: Int {
        tasksCells.count
    }
    
    public func getTask(name: String) -> Task{
        let task = tasksCells.containing(NSPredicate(format: "label == %@", name))
        return Task(element: task.element)
    }
    
    public func getTask(index: Int) -> Task {
        let task = tasksCells.element(boundBy: index)
        return Task(element: task)
    }
}


