//
//  Biography.swift
//  BioGraphAI
//
//  Created by Alan Badillo Salas on 13/05/23.
//

import Foundation

struct Biography {
    
    var name: String
    var picture: Data
    var content: String
    
    var summary: String {
        content.components(separatedBy: "\n").first ?? content
    }
    
}
