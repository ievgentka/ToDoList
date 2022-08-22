//
//  CreateTaskTests.swift
//  ToDoListUITests
//
//  Created by Eugene Tkachenko on 18.08.2022.
//  Copyright © 2022 Radu Ursache - RanduSoft. All rights reserved.
//

import XCTest

class CreateTaskTests: BaseTest {

    func testCreateEmptyTask() {
        let homeScreen = launchApp
        let addTaskScreen = homeScreen.addTask
        
        let savingError = addTaskScreen.saveEmptyTask()
        XCTAssertTrue(savingError, "Save error does not appear when saving an empty task")
        
        let content = CommonHelpers.randomString(charset: .english, length: 10)
        
        addTaskScreen
            .addTaskContent(content)
            .saveTask()
        
        let allTaskScreen = homeScreen.openTaskList(screen: .all)
        let notEmptyTask = allTaskScreen.getTask(name: content)
        XCTAssertTrue(notEmptyTask.exists, "Task not created after Save error alert occurs")
    }
    
    func testCancelCreateTask() {
        let homeScreen = launchApp
        homeScreen
            .addTask
            .cancelTaskCreation()
        XCTAssertEqual(homeScreen.tasksQuantityInside(section: .all), "0", "Incorrect number of created tasks. Expected result: 0 task")
        
        let content = CommonHelpers.randomString(charset: .english, length: 10)
        homeScreen
            .addTask
            .addTaskContent(content)
            .cancelTaskCreation()
        XCTAssertEqual(homeScreen.tasksQuantityInside(section: .all), "0", "Incorrect number of created tasks. Expected result: 0 task")
    
        homeScreen
            .addTask
            .addTaskContent(content)
            .setDate(day: .tomorrow)
            .cancelTaskCreation()
        XCTAssertEqual(homeScreen.tasksQuantityInside(section: .all), "0", "Incorrect number of created tasks. Expected result: 0 task")
        
        homeScreen
            .addTask
            .addTaskContent(content)
            .setDate(day: .tomorrow)
            .saveTask()
        XCTAssertEqual(homeScreen.tasksQuantityInside(section: .all), "1", "Incorrect number of created tasks. Expected result: 1 task")
        
    }
    
    func testCreateTasksWithSameContent() {
        let homeScreen = launchApp
        let content = CommonHelpers.randomString(charset: .english, length: 10)
        
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
    
    func testCreateTasksWithHugeString() {
        let homeScreen = launchApp
        let content = CommonHelpers.randomString(charset: .english, length: 1000)
        
        homeScreen
            .addTask
            .addTaskContent(content)
            .saveTask()
        XCTAssertEqual(homeScreen.tasksQuantityInside(section: .all), "1", "Incorrect number of existing tasks")
    
        let allTaskScreen = homeScreen.openTaskList(screen: .all)
        
        XCTAssertTrue(allTaskScreen.getTask(name: content).exists, "Task with huge string not exist inside All Tasks screen")
        XCTAssertEqual(allTaskScreen.countTasks, 1, "Incorrect number of existing tasks")
    }
    
    func testCreateTaskForToday() {
        let homeScreen = launchApp
        
        let content = CommonHelpers.randomString(charset: .english, length: 10)
        
        homeScreen
            .addTask
            .addTaskContent(content)
            .setDate(day: .today)
            .saveTask()
        XCTAssertEqual(homeScreen.tasksQuantityInside(section: .all), "1", "Incorrect number of created tasks. Expected result: 1 task")
        XCTAssertEqual(homeScreen.tasksQuantityInside(section: .today), "1", "Incorrect number of created tasks. Expected result: 1 task")
        XCTAssertEqual(homeScreen.tasksQuantityInside(section: .tomorrow), "0", "Incorrect number of created tasks. Expected result: 0 task")
        XCTAssertEqual(homeScreen.tasksQuantityInside(section: .week), "1", "Incorrect number of created tasks. Expected result: 1 task")
        
        let allTasksScreen = homeScreen.openTaskList(screen: .all)
        XCTAssertEqual(allTasksScreen.countTasks, 1)
        XCTAssertTrue(allTasksScreen.getTask(name: content).exists, "Task with content:'\(content)'does not exist")
        XCTAssertTrue(allTasksScreen.getTask(date: .today).exists, "Task with the desired date were not found")
    }
    
    func testCreateTaskForTomorrow() {
        let homeScreen = launchApp
        
        let content = CommonHelpers.randomString(charset: .english, length: 10)
        
        homeScreen
            .addTask
            .addTaskContent(content)
            .setDate(day: .tomorrow)
            .saveTask()
        XCTAssertEqual(homeScreen.tasksQuantityInside(section: .all), "1", "Incorrect number of created tasks. Expected result: 1 task")
        XCTAssertEqual(homeScreen.tasksQuantityInside(section: .tomorrow), "1", "Incorrect number of created tasks. Expected result: 1 task")
        XCTAssertEqual(homeScreen.tasksQuantityInside(section: .week), "1", "Incorrect number of created tasks. Expected result: 1 task")
        
        let tomorrowTasksScreen = homeScreen.openTaskList(screen: .tomorrow)
        XCTAssertEqual(tomorrowTasksScreen.countTasks, 1, "Incorrect number of created tasks. Expected result: 1 task")
        XCTAssertTrue(tomorrowTasksScreen.getTask(name: content).exists, "Task with content:'\(content)'does not exist")
        XCTAssertTrue(tomorrowTasksScreen.getTask(date: .tomorrow).exists, "Task with the desired date were not found")
    }
    
    func testCreateTaskNextSevenDays() {
        let homeScreen = launchApp
        
        let content = CommonHelpers.randomString(charset: .english, length: 10)
        
        homeScreen
            .addTask
            .addTaskContent(content)
            .setDate(day: .afterSevenDays)
            .saveTask()
        XCTAssertEqual(homeScreen.tasksQuantityInside(section: .all), "1", "Incorrect number of created tasks. Expected result: 1 task")
        XCTAssertEqual(homeScreen.tasksQuantityInside(section: .tomorrow), "0", "Incorrect number of created tasks. Expected result: 0 task")
        XCTAssertEqual(homeScreen.tasksQuantityInside(section: .week), "1", "Incorrect number of created tasks. Expected result: 1 task")
        
        let weekTasksScreen = homeScreen.openTaskList(screen: .week)
        XCTAssertEqual(weekTasksScreen.countTasks, 1, "Incorrect number of created tasks. Expected result: 1 task")
        XCTAssertTrue(weekTasksScreen.getTask(name: content).exists, "Task with content:'\(content)'does not exist")
        XCTAssertTrue(weekTasksScreen.getTask(date: .afterSevenDays).exists, "Task with the desired date were not found")
    }
    
    func testCreateTaskNextEightDays() {
        let homeScreen = launchApp
        
        let content = CommonHelpers.randomString(charset: .english, length: 10)
            
        homeScreen
            .addTask
            .addTaskContent(content)
            .setDate(day: .afterEightDays)
            .saveTask()
        XCTAssertEqual(homeScreen.tasksQuantityInside(section: .all), "1", "Incorrect number of created tasks. Expected result: 1 task")
        XCTAssertEqual(homeScreen.tasksQuantityInside(section: .tomorrow), "0", "Incorrect number of created tasks. Expected result: 0 task")
        XCTAssertEqual(homeScreen.tasksQuantityInside(section: .week), "0", "Incorrect number of created tasks. Expected result: 0 task")
        
        let allTasksScreen = homeScreen.openTaskList(screen: .all)
        XCTAssertEqual(allTasksScreen.countTasks, 1, "Incorrect number of created tasks. Expected result: 1 task")
        XCTAssertTrue(allTasksScreen.getTask(name: content).exists, "Task with content:'\(content)'does not exist")
        XCTAssertTrue(allTasksScreen.getTask(date: .afterEightDays).exists, "Task with the desired date were not found")
    
    }
    
}
