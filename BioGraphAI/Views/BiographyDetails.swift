//
//  BiographyDetails.swift
//  BioGraphAI
//
//  Created by Alan Badillo Salas on 13/05/23.
//

import SwiftUI

struct BiographyDetails: View {
    var biography: BiographyModel?
    
    var body: some View {
        if let biography = biography {
            ScrollView(.vertical) {
                VStack {
                    Image(data: biography.picture)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .clipShape(Circle())
                    Text(biography.name ?? "Unkown")
                        .font(.title)
                    Divider()
                    Text(biography.content ?? "No biography")
                        .padding()
                }
                .padding()
            }
            .padding()
            .navigationBarTitle("Biography Details")
        } else {
            Text("No biography")
                .foregroundColor(.secondary)
                .italic()
                .navigationBarTitle("Biography Details")
        }
    }
}

struct BiographyDetails_Previews: PreviewProvider {
    @EnvironmentObject static var store: Store
    
    static var previews: some View {
        BiographyDetails(biography: nil)
    }
}
