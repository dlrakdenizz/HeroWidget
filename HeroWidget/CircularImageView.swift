//
//  CircularImageView.swift
//  HeroWidget
//
//  Created by Dilara Akdeniz on 26.09.2024.
//

import SwiftUI

struct CircularImageView: View {
    
    var image : Image
    
    var body: some View {
        image.resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .overlay(Circle()
                .stroke(Color.purple, lineWidth: 5))//stroke overlay ile yapılan Circle'ın sadece resmin etrafında olmasını sağlar
            .shadow(radius: 15)
    }
}

#Preview {
    CircularImageView(image: Image("batman"))
}
