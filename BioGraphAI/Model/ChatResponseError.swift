//
//  ChatResponseError.swift
//  BioGraphAI
//
//  Created by Alan Badillo Salas on 13/05/23.
//

import Foundation

struct ChatResponseError: Decodable {
    var error: ChatError
    
    struct ChatError: Decodable {
        var code: String
        var message: String
        var type: String
    }
}
