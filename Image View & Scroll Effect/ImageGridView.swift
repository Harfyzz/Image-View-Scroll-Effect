//
//  ImageGridView.swift
//  Image View & Scroll Effect
//
//  Created by Afeez Yunus on 26/06/2024.
//

import SwiftUI

struct ImageGridView: View {
    @State private var isOpen = false
    @State private var selectedImage = ""
    @Namespace private var animation
    
    let images = ["Image 1", "Image 2", "Image 3", "Image 4", "Image 5", "Image 6", "Image 7", "Image 8"]
    
    var body: some View {
           if !isOpen {
               GeometryReader { proxy in
                   LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                       ForEach(images, id: \.self) { image in
                           Image(image)
                               .resizable()
                               .aspectRatio(contentMode: .fill)
                               .matchedGeometryEffect(id: image, in: animation)
                               .frame(width: (proxy.size.width / 3) - 16, height: 130)
                               .clipShape(RoundedRectangle(cornerRadius: 8))
                               .onTapGesture {
                                   withAnimation(.bouncy(duration: 0.3)) {
                                       selectedImage = image
                                       isOpen = true
                                   }
                               }
                       }
                   }
                   .padding(16)
               }
           } else {
               SingleView(selectedImage: $selectedImage, animation: animation, isOpen: $isOpen)
           }
       }
}

#Preview {
    ImageGridView()
}
