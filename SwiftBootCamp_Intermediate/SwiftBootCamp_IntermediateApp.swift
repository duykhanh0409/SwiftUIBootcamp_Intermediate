//
//  SwiftBootCamp_IntermediateApp.swift
//  SwiftBootCamp_Intermediate
//
//  Created by Thuocsi on 17/03/2023.
//

import SwiftUI

@main
struct SwiftBootCamp_IntermediateApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            BackgroundThreadBootcamp()
        }
    }
}
