//
//  ArtistItem.swift
//  ArtParallaxCarousel
//
//  Created by Alisa Serhiienko on 26.01.2024.
//
import SwiftUI

struct ArtistItem: View {
    let musician: Artist
    let screen: CGSize
    let width: CGFloat
    
    // Calculate parallax effect percentage
    private func parallaxPercentage(proxy: GeometryProxy) -> CGFloat {
        let midX = proxy.frame(in: .global).midX
        let distance = abs(screen.width / 2 - midX)
        let damping: CGFloat = 7
        return abs(distance / (screen.width / 2.4) / damping - 1)
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                Image(musician.image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(width: width * 0.9, height: width * 1.6)
                    .shadow(color: .black.opacity(0.5), radius: 8, y: 8)
                
                Text(musician.title)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
            }
            .frame(maxHeight: .infinity)
            .scaleEffect(parallaxPercentage(proxy: proxy))
        }
        .frame(width: width)
        .frame(maxHeight: .infinity)
    }
}


#Preview {
    ContentView()
}

