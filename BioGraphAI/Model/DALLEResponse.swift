//
//  DALLEResponse.swift
//  BioGraphAI
//
//  Created by Alan Badillo Salas on 13/05/23.
//

import Foundation

struct DALLEResponse: Decodable {
    let created: Int
    let data: [Photo]
}
