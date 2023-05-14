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
    @State var showingAddBiography = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Biographies here")
                
                Spacer()
                
                HStack() {
                    Spacer()
                    NavigationLink() {
                        DetailView()
                            .navigationTitle("Details")
                    } label: {
                        Text("Explore Biographies")
                    }
                    Spacer()
                }
                .padding()
            }
            .padding()
            .navigationTitle("BioGraphAI 👾")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor)
            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button() {
//
//                    } label: {
//                        Image(systemName: "person.circle")
//                    }
//                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    /*Button() {
                        showingAddBiography.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }*/
                    NavigationLink {
                        BiographyAdd()
                            .navigationTitle("Add Biography")
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
//                ToolbarItemGroup(placement: .secondaryAction) {
//                    Button("Settings") {
//                    }
//
//                    Button("About") {
//                    }
//                }
            }
            .sheet(isPresented: $showingAddBiography) {
                BiographyAdd()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
