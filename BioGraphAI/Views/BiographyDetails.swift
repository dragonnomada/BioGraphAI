//
//  BiographyDetails.swift
//  BioGraphAI
//
//  Created by Alan Badillo Salas on 13/05/23.
//

import SwiftUI

struct BiographyDetails: View {
    var biography: Biography
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Image(data: biography.picture)!
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipped()
                    .clipShape(Circle())
                Text(biography.name)
                    .font(.title)
                Divider()
                Text(biography.content)
                    .padding()
            }
            .padding()
        }
        .padding()
        .navigationBarTitle("Biography Details")
    }
}

struct BiographyDetails_Previews: PreviewProvider {
    static var previews: some View {
        BiographyDetails(biography: Store.withSample(total: 1).biographies.first!)
    }
}
