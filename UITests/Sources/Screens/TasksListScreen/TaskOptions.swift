//
//  TaskOptions.swift
//  ToDoListUITests
//
//  Created by Eugene Tkachenko on 18.08.2022.
//  Copyright © 2022 Radu Ursache - RanduSoft. All rights reserved.
//

import XCTest

public class TaskOptions {
    private let taskOptionsSheet = XCUIApplication().sheets["Task options"]
    
    public func waitForOpen() {
        _ = taskOptionsSheet.waitToExist()
    }
    
    public var openEditOption: EditTaskScreen {
        let editOptionButton = taskOptionsSheet.buttons["Edit"]
        editOptionButton.tap()
        
        let editTaskScreen = EditTaskScreen()
        editTaskScreen.waitToExist()
        return editTaskScreen
    }
}
