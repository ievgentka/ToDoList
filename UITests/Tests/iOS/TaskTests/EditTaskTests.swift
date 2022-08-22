//
//  EditTaskTests.swift
//  ToDoListUITests
//
//  Created by Eugene Tkachenko on 18.08.2022.
//  Copyright © 2022 Radu Ursache - RanduSoft. All rights reserved.
//

import XCTest

class EditTaskTests: BaseTest {

    func testEditTask() {
        let homeScreen = launchApp
        
        let content = CommonHelpers.randomString(charset: .english, length: 30)
        let newContent = CommonHelpers.randomString(charset: .english, length: 30)
        
        homeScreen
            .addTask
            .addTaskContent(content)
            .saveTask()
        XCTAssertEqual(homeScreen.tasksQuantityInside(section: .all), "1", "Incorrect number of existing tasks")
        
        let allTasksScreen = homeScreen.openTaskList(screen: .all)
        allTasksScreen
            .getTask(name: content)
            .select
            .openEditOption
            .clearAndAddTaskContent(newContent)
            .saveTask()
        
        let taskWithNewContent = allTasksScreen.getTask(name: newContent)
        XCTAssertTrue(taskWithNewContent.exists, "Task with new content: \(newContent) does not exist")
        XCTAssertEqual(allTasksScreen.countTasks, 1, "Incorrect number of existing tasks")
        
        taskWithNewContent.delete
        // Reopening the screen due to an existing bug in the app: The UI is updating, but tree of elements updates only after screen reopen
        allTasksScreen
            .openHomeScreen
            .openTaskList(screen: .all)
        XCTAssertEqual(allTasksScreen.countTasks, 0, "Incorrect number of existing tasks")
    }
    
}
