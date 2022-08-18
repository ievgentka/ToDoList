//
//  BaseTest.swift
//  ToDoListUITests
//
//  Created by Eugene Tkachenko on 18.08.2022.
//  Copyright © 2022 Radu Ursache - RanduSoft. All rights reserved.
//

import XCTest

class BaseTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = true
    }

    override func tearDownWithError() throws {
        deleteAllTask()
    }

    public var launchApp: HomeScreen {
        let app = XCUIApplication()
  
        app.launch()
        XCTAssertEqual(app.state, .runningForeground)

        skipOnboarding()
        waitICloudErrorToDisappear()
        let homeScreen = HomeScreen()
        homeScreen.waitToExist()
        
        return homeScreen
    }
    
    // TODO: Remove all this private func from launchApp() after add launchArguments to app for clean install state and skip onboarding
    private func skipOnboarding() {
        // TODO: Change labels to IDs for elements locators in this func
        let welcomeTitle = XCUIApplication().staticTexts["Welcome to ToDoList"]
        if welcomeTitle.exists {
        XCUIApplication().buttons["Continue"].tap()
        waitForElement(welcomeTitle, toExist: false)
        
        let welcomePushNotificationTitle = XCUIApplication().staticTexts["Receive push notifications for reminders"]
        XCUIApplication().buttons["Not now"].tap()
        waitForElement(welcomePushNotificationTitle, toExist: false)
        
        let welcomeDoneTitle = XCUIApplication().staticTexts["Onboarding done"]
        XCUIApplication().buttons["Get started"].tap()
        waitForElement(welcomeDoneTitle, toExist: false)
        }
    }
    
    private func waitICloudErrorToDisappear() {
        let icloudErrorLabel = XCUIApplication().staticTexts["You are not logged in iCloud. Your tasks won't be synced!"].firstMatch
        if icloudErrorLabel.exists {
        waitForElement(icloudErrorLabel, toExist: false)
        }
    }
    
    private func deleteAllTask() {
        let homeScreen = launchApp
        
        if homeScreen.tasksQuantityInside(section: .all) != "0" {
            let tasksListScreen = homeScreen.openTaskList(screen: .all)
            let countTasks = tasksListScreen.countTasks
            for _ in 0..<countTasks {
                _ = tasksListScreen.getTask(index: 0).delete
            }
            _ = tasksListScreen.openHomeScreen
        }
    }
}
