//
//  TasksTests.swift
//  ToDoListUITests
//
//  Created by Eugene Tkachenko on 18.08.2022.
//  Copyright © 2022 Radu Ursache - RanduSoft. All rights reserved.
//

import XCTest

class TasksTests: BaseTest {
    
    func testCreateEmptyTask() {
        let homeScreen = launchApp
        let addTaskScreen = homeScreen.addTask
        let content = CommonHelpers.randomString(charset: .english, length: 10)
        
        let saveErrorExist = addTaskScreen.saveEmptyTask()
        XCTAssertTrue(saveErrorExist)
        
        addTaskScreen
            .addTaskContent(content)
            .saveTask()
        
        let allTaskScreen = homeScreen.openTaskList(screen: .all)
        let notEmptyTask = allTaskScreen.getTask(name: content)
        XCTAssertTrue(notEmptyTask.exists, "Can't create task after Save error alert occurs")
    }
    
    func testCreateTasksWithSameContent() {
        let homeScreen = launchApp
        let content = CommonHelpers.randomString(charset: .english, length: 30)
        
        homeScreen
            .addTask
            .addTaskContent(content)
            .saveTask()
        XCTAssertEqual(homeScreen.tasksQuantityInside(section: .all), "1", "Incorrect number of existing tasks")

        homeScreen
            .addTask
            .addTaskContent(content)
            .saveTask()
        XCTAssertEqual(homeScreen.tasksQuantityInside(section: .all), "2", "Incorrect number of existing tasks")
        
        let allTaskScreen = homeScreen.openTaskList(screen: .all)
        let firstTaskContent = allTaskScreen.getTask(index: 0).content
        XCTAssertEqual(firstTaskContent, content, "Wrong content inside created task")
        let secondTaskContent = allTaskScreen.getTask(index: 1).content
        XCTAssertEqual(secondTaskContent, content, "Wrong content inside created task")
    }
    
    func testCreateAndDeleteTasks() {
        let homeScreen = launchApp
        
        let englishString = CommonHelpers.randomString(charset: .english, length: 30)
        let сyrillicString = CommonHelpers.randomString(charset: .сyrillic, length: 30)
        
        homeScreen
            .addTask
            .addTaskContent(englishString)
            .saveTask()
        XCTAssertEqual(homeScreen.tasksQuantityInside(section: .all), "1", "Incorrect number of existing tasks")

        homeScreen
            .addTask
            .addTaskContent(сyrillicString)
            .saveTask()
        XCTAssertEqual(homeScreen.tasksQuantityInside(section: .all), "2", "Incorrect number of existing tasks")
        
        let allTasksScreen = homeScreen.openTaskList(screen: .all)
        XCTAssertEqual(allTasksScreen.countTasks, 2)
        
        allTasksScreen
            .getTask(name: englishString)
            .delete
            .getTask(name: сyrillicString)
            .delete
        // Reopening the screen due to an existing bug in the app: The UI is updating, but tree of elements updates only after screen reopen
        _ = allTasksScreen.openHomeScreen.openTaskList(screen: .all)
        XCTAssertEqual(allTasksScreen.countTasks, 0, "Incorrect number of existing tasks")
    }
    
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
        _ = allTasksScreen.openHomeScreen.openTaskList(screen: .all)
        XCTAssertEqual(allTasksScreen.countTasks, 0, "Incorrect number of existing tasks")
    }
}
