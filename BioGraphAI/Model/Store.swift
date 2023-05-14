//
//  Store.swift
//  BioGraphAI
//
//  Created by Alan Badillo Salas on 13/05/23.
//

import Foundation

class Store: ObservableObject {
    
    @Published var biographies: [Biography] = []
    
    static func withSample(total n: Int) -> Store {
        
        let store = Store()
        
        for i in 1...n {
            store.biographies.append(Biography(name: "Sample \(i)", picture: (try? Data(contentsOf: URL(string: "https://codingbootcamps.io/wp-content/uploads/swift.png")!)) ?? Data(), content: "Sample content"))
        }
        
        return store
        
    }
    
}
