//
//  DeleteTaskTests.swift
//  ToDoListUITests
//
//  Created by Eugene Tkachenko on 18.08.2022.
//  Copyright © 2022 Radu Ursache - RanduSoft. All rights reserved.
//

import XCTest

class DeleteTaskTests: BaseTest {
    
    func testDeleteTasks() {
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
        XCTAssertEqual(allTasksScreen.countTasks, 2, "Incorrect number of existing tasks")
        
        allTasksScreen
            .getTask(name: englishString)
            .delete
            .getTask(name: сyrillicString)
            .delete
        // Reopening the screen due to an existing bug in the app: The UI is updating, but tree of elements updates only after screen reopen
        allTasksScreen
            .openHomeScreen
            .openTaskList(screen: .all)
        XCTAssertEqual(allTasksScreen.countTasks, 0, "Incorrect number of existing tasks")
    }
}
