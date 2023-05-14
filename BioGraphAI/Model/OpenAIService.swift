//
//  OpenAIService.swift
//  BioGraphAI
//
//  Created by Alan Badillo Salas on 13/05/23.
//

import Foundation

class OpenAIService: ObservableObject{
    
    var apiKey: String {
        guard let path = Bundle.main.path(forResource: "keys", ofType: "plist")
        else {
            return "unknown"
        }
        
        guard let keys = NSDictionary(contentsOfFile: path)
        else {
            return "unknown"
        }
        
        guard let apiKey = keys["openai_secret_key"] as? String
        else {
            return "unknown"
        }
        
        return apiKey
    }
    
    func generateChat(from prompt: String) async throws -> (chat: String, errorCode: String?, errorMessage: String?) {
        var request = URLRequest(url: OpenAIEndpoint.completions.url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let parameters: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                [
                    "role": "user",
                    "content": prompt
                ]
            ]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        
        if let jsonData = jsonData {
            if let text = String(data: jsonData, encoding: .utf8) {
                print(text)
            }
        }
        
        request.httpBody = jsonData

        let (data, _) = try await URLSession.shared.data(for: request)
        
        if let text = String(data: data, encoding: .utf8) {
            print(text)
        }
        
        if let chatResponse = try? JSONDecoder().decode(ChatResponse.self, from: data) {
            return (chatResponse.choices.first!.message.content, nil, nil)
        }
        
        if let chatResponseError = try? JSONDecoder().decode(ChatResponseError.self, from: data) {
            return ("", chatResponseError.error.code, chatResponseError.error.message)
        }
        
        return ("", "unknown", "Unhandled error (OpenAIService.generateChat)")
    }
    
    func generateImage(from prompt: String, total n: Int) async throws -> (photos: [Photo], errorCode: String?, errorMessage: String?) {
        var request = URLRequest(url: OpenAIEndpoint.generations.url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let parameters: [String: Any] = [
            "prompt": prompt,
            "n": n,
            "size": "256x256"
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        
        if let jsonData = jsonData {
            if let text = String(data: jsonData, encoding: .utf8) {
                print(text)
            }
        }
        
        request.httpBody = jsonData

        let (data, _) = try await URLSession.shared.data(for: request)
        
        if let text = String(data: data, encoding: .utf8) {
            print(text)
        }
        
        if let dalleResponse = try? JSONDecoder().decode(DALLEResponse.self, from: data) {
            return (dalleResponse.data, nil, nil)
        }
        
        if let dalleResponseError = try? JSONDecoder().decode(DALLEResponseError.self, from: data) {
            return ([], dalleResponseError.error.code, dalleResponseError.error.message)
        }
        
        return ([], "unknown", "Unhandled error (OpenAIService.generateImage)")
    }
}
