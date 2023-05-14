//
//  OpenAIEndpoint.swift
//  BioGraphAI
//
//  Created by Alan Badillo Salas on 13/05/23.
//

import Foundation

enum OpenAIEndpoint: String {
    
    private var baseURLImage: String { "https://api.openai.com/v1/images/" }
    private var baseURLChat: String { "https://api.openai.com/v1/chat/" }
    
    case generations
    case edits
    case completions
    
    var url: URL {
        var baseURL: String
        
        switch self {
        case .generations:
            baseURL = baseURLImage
        case .edits:
            baseURL = baseURLImage
        case .completions:
            baseURL = baseURLChat
        }
        
        guard let url = URL(string: baseURL)
        else {
            preconditionFailure("Invalid url: \(baseURL)")
        }
        
        return url.appendingPathComponent(self.rawValue)
    }
    
}
