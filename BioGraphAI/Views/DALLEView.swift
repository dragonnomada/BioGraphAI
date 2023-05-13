//
//  DALLEView.swift
//  BioGraphAI
//
//  Created by Alan Badillo Salas on 13/05/23.
//

import SwiftUI

struct DALLEView: View {
    
    @ObservedObject var openAI = OpenAIService()
    @State var photos : [Photo] = []
    @State private var textPrompt: String = "Coca Cola"
    @State var loading = false
    
    var body: some View {
            VStack {
                
                if loading {
                    ProgressView()
                }
                
                if photos.count == 0 {
                    Text("Empty photos")
                        .font(.title)
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 20) {
                       ForEach(photos, id: \.url) { photo in
                           AsyncImage(url: URL(string: photo.url)) { image in
                                       image
                                           .resizable()
                                           .aspectRatio(contentMode: .fit)
                           } placeholder: {
                               Image(systemName: "photo.fill")
                           }
                           .frame(width: 200, height: 200)
                       }
                    }
                }

                TextField("Enter the prompt", text: $textPrompt)
                            .padding()
                
                Button(action: runOpenAIGeneration, label: {Text("Generate Image")})
            }
            .padding()
        }
        
        func runOpenAIGeneration(){
            loading = true
            photos = []
            Task{
                do{
                    let (photos, errorCode, errorMessage) = try await openAI.generateImage(from: textPrompt, total: 3)
                    
                    if let errorCode = errorCode, let errorMessage = errorMessage {
                        print("ERROR: [\(errorCode)] \(errorMessage)")
                    }
                    
                    self.photos = photos
                    
                    loading = false
                }catch(let error){
                    print(error)
                    loading = false
                }
            }
        }
    
}

struct DALLEView_Previews: PreviewProvider {
    static var previews: some View {
        DALLEView()
    }
}
