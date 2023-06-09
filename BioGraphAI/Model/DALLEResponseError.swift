//
//  DALLEResponseError.swift
//  BioGraphAI
//
//  Created by Alan Badillo Salas on 13/05/23.
//

import Foundation

struct DALLEResponseError: Decodable {
    
    var error: DALLEError
    
    struct DALLEError: Decodable {
        var code: String
        var message: String
        var type: String
    }
    
}
