//
//  ContentView.swift
//  BioGraphAI
//
//  Created by Alan Badillo Salas on 13/05/23.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        Text("Hello")
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("Details") {
                    DetailView()
                        .navigationTitle("Details")
                }
            }
            .navigationTitle("BioGraphAI 👾")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button() {
                        
                    } label: {
                        Image(systemName: "person.circle")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button() {
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItemGroup(placement: .secondaryAction) {
                    Button("Settings") {
                    }
                    
                    Button("About") {
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
