//
//  BioGraphAIApp.swift
//  BioGraphAI
//
//  Created by Alan Badillo Salas on 13/05/23.
//

import SwiftUI

@main
struct BioGraphAIApp: App {
    @StateObject var store = Store()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
