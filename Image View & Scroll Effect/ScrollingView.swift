//
//  ContentView.swift
//  Image View & Scroll Effect
//
//  Created by Afeez Yunus on 26/06/2024.
//

import SwiftUI

struct ScrollingView: View {
    
    @Binding var selectedImage:String
    @State var isSelected = false
    var nameSpace:Namespace.ID
    @Binding var isOpen:Bool
    @Binding var imageShowcase:viewing
    
    var body: some View {
        GeometryReader { proxy in
            VStack{
                Button("Close") {
                    withAnimation (.bouncy(duration: 0.3)){
                        isOpen = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            imageShowcase = .base
                        }
                    }
                    
                }
                ScrollView(.horizontal){
                    ScrollViewReader{ select in
                        let gallery = ImageGridView()
                        HStack{
                            ForEach (gallery.images, id: \.self) { image in
                                
                                Image(image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .matchedGeometryEffect(id: image, in: nameSpace,isSource: selectedImage == image)
                                    .frame(width: (proxy.size.width) - 32, height: 600)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .containerRelativeFrame(.horizontal, count: 1, spacing: 32)
                                    .onChange(of: selectedImage) { oldValue, newValue in
                                        select.scrollTo(selectedImage)
                                    }
                                    .onAppear{
                                        select.scrollTo(selectedImage)
                                    }
                                
                                
                                
                            }
                        }.scrollTargetLayout()
                        
                        
                        
                    }
                }
                .contentMargins(16, for: .scrollContent)
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.viewAligned)
                
                
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


struct imageThumbnail: View {
    
    @State var image:String
    @Binding var isSelected:Bool
    @Binding var selectedImage:String
    var body: some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width:selectedImage == image && isSelected ? 100 : 64, height: 64)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay{
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.white, lineWidth: 3)
            }
            .onAppear{
                isSelected = true
            }
        //.rotationEffect(.degrees(Double.random(in: -25...25)))
    }
}
