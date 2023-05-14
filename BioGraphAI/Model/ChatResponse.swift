//
//  ChatResponse.swift
//  BioGraphAI
//
//  Created by Alan Badillo Salas on 13/05/23.
//

import Foundation

struct ChatResponse: Decodable {
    
    let id: String
    let object: String
    let created: Int
    let choices: [ChatChoice]
    let usage: ChatUsage
    
    struct ChatChoice: Decodable {
        let index: Int
        let message: ChatMessage
        let finish_reason: String
    }
    
    struct ChatMessage: Decodable {
        let role: String
        let content: String
    }
    
    struct ChatUsage: Decodable {
        let prompt_tokens: Int
        let completion_tokens: Int
        let total_tokens: Int
    }
    
}
