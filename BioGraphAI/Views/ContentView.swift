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
    @EnvironmentObject var store: Store
    
    @State var showingAddBiography = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                if store.biographies.count == 0 {
                    Spacer()
                    Text("There are not biographies")
                        .font(.callout)
                        .italic()
                        .foregroundColor(.secondary)
                    Spacer()
                } else {
                    List(store.biographies, id: \.id) { (biography: BiographyModel) in
                        NavigationLink {
                            BiographyDetails(biography: biography)
                        } label: {
                            VStack {
                                HStack {
                                    Image(data: biography.picture)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipped()
                                        .clipShape(Circle())
                                    
                                    Text(biography.name ?? "Unknown")
                                        .bold()
                                }
                                Text(biography.summary ?? "No biography")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                
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
            .environmentObject(Store())
    }
}
