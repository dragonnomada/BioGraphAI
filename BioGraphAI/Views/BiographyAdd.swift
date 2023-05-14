//
//  BiographyAdd.swift
//  BioGraphAI
//
//  Created by Alan Badillo Salas on 13/05/23.
//

import SwiftUI

struct BiographyAdd: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var store: Store
    
    @ObservedObject var openAI = OpenAIService()
    
    @State var name: String = "Albert Einstein"
    
    @State var photos: [Photo] = [
//        Photo(url: "https://codingbootcamps.io/wp-content/uploads/swift.png"),
//        Photo(url: "https://developer.apple.com/swift/images/swift-og.png"),
//        Photo(url: "https://cdn-media-1.freecodecamp.org/images/1*S4__g3knEbuuE6qHyWIbNQ.png")
    ]
    @State var selectedPhoto: Photo? = nil
    
    @State var loadingPhothos = false
    @State var loadingChat = false
    @State var errorPhotos: String? = nil
    @State var errorChat: String? = nil
    @State var errorGeneral: String? = nil
    @State var showErrorGeneral: Bool = false
    
    @State var biography: String? = nil
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                
                Text("1. Set the name of important person")
                    .font(.title2)
                    .bold()
                
                HStack {
                    TextField("Name", text: $name)
                    
                    Button("Ok") {
                        loadPhotosAndChat()
                    }
                    .disabled(loadingPhothos || loadingChat)
                }
                .padding()
                
                Text("2. Choose the correct image for this person")
                    .font(.title2)
                    .bold()
                
                if loadingPhothos || photos.count == 0 || errorPhotos != nil {
                    VStack(alignment: .leading) {
                        if loadingPhothos {
                            ProgressView()
                        }
                        
                        if !loadingPhothos && photos.count == 0 {
                            Text("Empty photos")
                                .font(.body)
                                .italic()
                                .foregroundColor(.secondary)
                        }
                        
                        if let error = errorPhotos {
                            Text("Error: \(error)")
                                .italic()
                                .foregroundColor(.red)
                        }
                    }
                    .padding()
                } else {
                    ScrollView(.horizontal) {
                        HStack(alignment: .top, spacing: 20) {
                            ForEach(photos, id: \.url) { photo in
                                Button {
                                    selectedPhoto = photo
                                } label: {
                                    AsyncImage(url: URL(string: photo.url)) { image in
                                        image
                                            .renderingMode(.original)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        Image(systemName: "photo.fill")
                                    }
                                    .frame(width: 200, height: 200)
                                    .clipped()
                                    .border(photo.url == selectedPhoto?.url ? .red : .gray, width: 1)
                                    .opacity(photo.url == selectedPhoto?.url ? 1 : 0.6)
                                    
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                Text("3. Check if the biography is correct")
                    .font(.title2)
                    .bold()
                
                VStack(alignment: .leading) {
                    if loadingChat {
                        ProgressView()
                    } else {
                        if let biography = biography {
                            Text(biography)
                                .italic()
                                .font(.callout)
                        } else {
                            Text("Not biography")
                                .font(.body)
                                .italic()
                                .foregroundColor(.secondary)
                            if let error = errorChat {
                                Text("Error: \(error)")
                                    .italic()
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                .padding()
                
                Text("4. Submit the biography")
                    .font(.title2)
                    .bold()
                
                VStack(alignment: .leading) {
                    HStack(alignment: .bottom) {
                        if let selectedPhoto = selectedPhoto {
                            AsyncImage(url: URL(string: selectedPhoto.url)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                Image(systemName: "photo.fill")
                            }
                            .frame(width: 100, height: 100)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        } else {
                            Image(systemName: "photo.fill")
                                .font(.largeTitle)
                                .frame(width: 100, height: 100)
                                .background(Color.gray.brightness(0.4))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        Text(name)
                            .font(.title)
                    }
                    Divider()
                    if let biography = biography {
                        Text(biography.split(separator: "\n").first ?? "")
                            .italic()
                            .font(.title2)
                    } else {
                        Text("Not biography")
                            .font(.body)
                            .italic()
                            .foregroundColor(.secondary)
                    }
                    Divider()
                    HStack {
                        Spacer()
                        Button("Add") {
                            guard let selectedPhoto = selectedPhoto
                            else { return }
                            
                            guard let url = URL(string: selectedPhoto.url)
                            else { return }
                            
                            guard let biography = biography
                            else { return }
                            
                            Task {
                                do {
                                    let data = try Data(contentsOf: url)
                                    
                                    store.biographies.append(Biography(name: name, picture: data, content: biography))
                                } catch(let error) {
                                    errorGeneral = "\(error)"
                                    showErrorGeneral = true
                                }
                                
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                        .disabled(errorPhotos != nil || errorChat != nil || selectedPhoto == nil || biography == nil || loadingPhothos || loadingChat)
                        Spacer()
                    }
                    .padding()
                }
                .padding()
            }
            .padding()
        }
        .padding()
        .alert(isPresented: $showErrorGeneral) {
            Alert(title: Text("Error: \(errorGeneral ?? "unknown")"))
        }
    }
    
    func loadPhotosAndChat() {
        Task {
            do {
                try await loadPhotos()
            } catch(let error){
                print(error)
                self.errorPhotos = "\(error)"
                loadingPhothos = false
            }
        }
        Task {
            do {
                try await loadChat()
            } catch(let error){
                print(error)
                self.errorChat = "\(error)"
                loadingChat = false
            }
        }
    }
    
    func loadPhotos() async throws {
        errorPhotos = nil
        loadingPhothos = true
        photos = []
        
        let search = "Face of \(name) person"
        
        let (photos, errorCode, errorMessage) = try await openAI.generateImage(from: search, total: 3)
        
        if let errorCode = errorCode, let errorMessage = errorMessage {
            print("ERROR: [\(errorCode)] \(errorMessage)")
            errorPhotos = "[\(errorCode)] \(errorMessage)"
        } else {
            self.photos = photos
            selectedPhoto = self.photos.first
        }
        
        loadingPhothos = false
    }
    
    func loadChat() async throws {
        errorChat = nil
        loadingChat = true
        biography = nil
        
        let search = "The biography of \(name) person"
        
        let (biography, errorCode, errorMessage) = try await openAI.generateChat(from: search)
        
        if let errorCode = errorCode, let errorMessage = errorMessage {
            print("ERROR: [\(errorCode)] \(errorMessage)")
            errorChat = "[\(errorCode)] \(errorMessage)"
        } else {
            self.biography = biography
        }
        
        loadingChat = false
    }
}

struct BiographyAdd_Previews: PreviewProvider {
    static var previews: some View {
        BiographyAdd()
            .environmentObject(Store())
    }
}
