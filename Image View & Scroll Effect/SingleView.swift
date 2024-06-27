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
                    ScrollViewReader{ reader in
                        let gallery = ImageGridView()
                        HStack(spacing:4){
                            ForEach (gallery.images, id: \.self) {
                                image in
                                imageThumbnail(image: image, isSelected: $isSelected, selectedImage: $selectedImage)
                                    .onTapGesture {
                                        withAnimation(.bouncy){
                                            selectedImage = image
                                            isSelected = true
                                        }
                                    }
                                
                            }
                        }.onChange(of: selectedImage) { oldValue, newValue in
                            withAnimation(.spring()){
                                reader.scrollTo(selectedImage,anchor: .center)
                            }
                        }
                        .onAppear{
                            withAnimation(.spring()){
                                reader.scrollTo(selectedImage,anchor: .center)
                            }
                        }
                    }
                }.scrollIndicators(.hidden)
                    .padding(.horizontal, 16)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }.padding(.vertical,32)
    }
}
        
