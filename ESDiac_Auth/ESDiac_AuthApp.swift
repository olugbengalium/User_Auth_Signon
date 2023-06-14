//
//  ESDiac_AuthApp.swift
//  ESDiac_Auth
//
//  Created by Gbenga Abayomi on 13/06/2023.
//

import SwiftUI
import CoreData


@main
struct ESDiac_AuthApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var checker = Checker()
    var body: some Scene {
        WindowGroup {
                        ContentView()
                .environmentObject(checker)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
