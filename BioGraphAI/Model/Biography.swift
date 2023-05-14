//
//  Biography.swift
//  BioGraphAI
//
//  Created by Alan Badillo Salas on 13/05/23.
//

import Foundation

extension BiographyModel {
    
    var summary: String? {
        content?.components(separatedBy: "\n").first
    }
    
}
