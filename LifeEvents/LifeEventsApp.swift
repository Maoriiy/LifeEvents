//
//  LifeEventsApp.swift
//  LifeEvents
//
//  Created by yihong wang on 2023/7/5.
//

import SwiftUI

@main
struct LifeEventsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeTabbar()
        }
    }
}
