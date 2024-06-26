//
//  ContentView.swift
//  Image View & Scroll Effect
//
//  Created by Afeez Yunus on 26/06/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedImage = ""
    @State var isSelected = false
    
    var images = ["Image 1","Image 2","Image 3","Image 4","Image 5","Image 6","Image 7","Image 8"]
    var body: some View {
        GeometryReader { proxy in
            VStack{
                
                ScrollView(.horizontal){
                    ScrollViewReader{ select in
                       
                            HStack{
                                ForEach (images, id: \.self) { image in
                                    Image(image)
                                        .resizable()
                                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                        .frame(width: (proxy.size.width) - 32, height: 600)
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                        .containerRelativeFrame(.horizontal, count: 1, spacing: 32)
                                        .onChange(of: selectedImage) { oldValue, newValue in
                                            withAnimation(.bouncy(duration: 0.2)){
                                                select.scrollTo(selectedImage)
                                            }
                                        }
                                    
                                }
                            }.scrollTargetLayout()
                        
                        
                    }
                }.contentMargins(16, for: .scrollContent)
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.viewAligned)
                    .onChange(of: selectedImage) { oldValue, newValue in
                        
                    }
                    
                
                
                ScrollView(.horizontal){
                    HStack{
                        ForEach (images, id: \.self) {
                            image in
                            Image(image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width:selectedImage == image && isSelected ? 100 : 64, height: 64)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .onTapGesture {
                                    withAnimation(.bouncy){
                                        selectedImage = image
                                        isSelected = true
                                    }
                                }
                                
                        }
                    }
                }.scrollIndicators(.hidden)
            }
        }.padding(.vertical,32)
    }
}
#Preview {
    ContentView()
}
