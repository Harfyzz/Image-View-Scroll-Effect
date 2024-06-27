//
//  SingleView.swift
//  Image View & Scroll Effect
//
//  Created by Afeez Yunus on 27/06/2024.
//

import SwiftUI

struct SingleView: View {
    @Binding var selectedImage: String
    var animation: Namespace.ID
    @Binding var isOpen: Bool
    @State var isSelected = false
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Button("Close") {
                    withAnimation(.bouncy(duration: 0.3)) {
                        isOpen = false
                    }
                }
                                Image(selectedImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .matchedGeometryEffect(id: selectedImage, in: animation)
                                    .frame(width: proxy.size.width - 32, height: 600)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .padding(.vertical)
                            
                        
                    
                
                
                ScrollView(.horizontal){
                    let gallery = ImageGridView()
                    HStack(spacing:4){
                        ForEach (gallery.images, id: \.self) {
                            image in
                            imageThumbnail(image: image, isSelected: $isSelected, selectedImage: $selectedImage)
                                .onTapGesture {
                                        selectedImage = image
                                        isSelected = true
                                }
                            
                        }
                    }
                }.scrollIndicators(.hidden)
            }
        }.padding(.vertical,32)
    }
}
        
