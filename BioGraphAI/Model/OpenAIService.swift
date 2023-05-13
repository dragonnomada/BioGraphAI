//
//  OpenAIService.swift
//  BioGraphAI
//
//  Created by Alan Badillo Salas on 13/05/23.
//

import Foundation

class OpenAIService: ObservableObject{
    
    let api_key = "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"
    
    func generateImage(from prompt: String, total n: Int) async throws -> (photos: [Photo], errorCode: String?, errorMessage: String?) {
        var request = URLRequest(url: OpenAIEndpoint.generations.url)
        request.setValue("Bearer \(api_key)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let parameters: [String: Any] = [
            "prompt": prompt,
            "n": n,
            "size": "256x256"
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        
        request.httpBody = jsonData

        let (data, _) = try await URLSession.shared.data(for: request)
        
        if let text = String(data: data, encoding: .utf8) {
            print(text)
        }
        
        if let dalleResponse = try? JSONDecoder().decode(DALLEResponse.self, from: data) {
            return (dalleResponse.data, nil, nil)
        }
        
        if let dalleResponseError = try? JSONDecoder().decode(DALLEResponseError.self, from: data) {
            print("Error: \(dalleResponseError.error.message)")
            return ([], dalleResponseError.error.code, dalleResponseError.error.message)
        }
        
        return ([], "unknown", "Unhandled error (OpenAIService.generateImage)")
    }
}
