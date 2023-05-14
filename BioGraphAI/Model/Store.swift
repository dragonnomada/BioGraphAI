//
//  Store.swift
//  BioGraphAI
//
//  Created by Alan Badillo Salas on 13/05/23.
//

import Foundation
import CoreData

class Store: ObservableObject {
    
    lazy var container = NSPersistentContainer(name: "BiographyModel")
    
    @Published var biographies: [BiographyModel] = []
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        
        if let results = try? container.viewContext.fetch(BiographyModel.fetchRequest()) {
            results.forEach { biography in
                biographies.append(biography)
            }
        }
    }
    
    static func withSample(total n: Int) -> Store {
        
        let store = Store()
        
        for i in 1...n {
            store.addBiography(
                name: "Sample \(i)",
                content: "Sample content",
                pictureURL: "https://codingbootcamps.io/wp-content/uploads/swift.png",
                save: false
            )
        }
        
        return store
        
    }
    
    func addBiography(name: String, content: String, pictureURL: String, save: Bool) {
        let biography = BiographyModel(context: container.viewContext)
        
        biography.id = UUID()
        biography.name = name
        biography.content = content
        if let url = URL(string: pictureURL) {
            if let data = try? Data(contentsOf: url) {
                biography.picture = data
            }
        }
        
        biographies.append(biography)
        
        if save {
            try? container.viewContext.save()
        }
    }
    
}
