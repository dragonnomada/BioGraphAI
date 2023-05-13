//
//  OpenAIEndpoint.swift
//  BioGraphAI
//
//  Created by Alan Badillo Salas on 13/05/23.
//

import Foundation

enum OpenAIEndpoint: String {
    
    private var baseURL: String { "https://api.openai.com/v1/images/" }
    
    case generations
    case edits
    
    var url: URL {
        guard let url = URL(string: baseURL)
        else {
            preconditionFailure("Invalid url: \(baseURL)")
        }
        return url.appendingPathComponent(self.rawValue)
    }
    
}
