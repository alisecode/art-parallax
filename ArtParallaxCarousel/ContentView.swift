//
//  ContentView.swift
//  ArtParallaxCarousel
//
//  Created by Alisa Serhiienko on 26.01.2024.
//

import SwiftUI

struct ContentView: View {
    let artists = Artist.artists
    @State private var offsetX: CGFloat = 0
    @State private var maxOffsetX: CGFloat = 0

    var body: some View {
        GeometryReader { proxy in
            let screen = proxy.size

            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                backCarousel(screenSize: screen)
                let itemWidth: CGFloat = screen.width * 0.9
                let paddingX: CGFloat = (screen.width - itemWidth) / 2

                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        GeometryReader { item -> Color in
                            DispatchQueue.main.async {
                                offsetX = (item.frame(in: .global).minX - paddingX) * -1
                                let scrollContentWidth = itemWidth * CGFloat(artists.count) + 12 * CGFloat(artists.count - 1)
                                maxOffsetX = scrollContentWidth + 2 * paddingX - screen.width
                            }
                            return Color.clear
                        }
                        HStack(spacing: 10) {
                            ForEach(artists) { art in
                                ArtistItem(musician: art, screen: screen, width: itemWidth)
                            }
                        }
                        .padding(.horizontal, paddingX)
                    }
                }
                .scrollIndicators(.hidden)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    func backCarousel(screenSize: CGSize) -> some View {
        let backWidth: CGFloat = screenSize.width * CGFloat(artists.count)
        let scrollPercentage = offsetX / maxOffsetX
        let clampedPercentage: CGFloat = 1 - max(0, min(scrollPercentage, 1))
        let positionX: CGFloat = (backWidth - screenSize.width) * clampedPercentage

        return HStack(spacing: 0) {
            ForEach(artists.reversed()) { art in
                Image(art.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: screenSize.width)
                    .frame(maxWidth: .infinity)
                    .blur(radius: 5)
                    .scaleEffect(1.01)
                    .clipped()
                    .overlay(content: {
                        Color.black.opacity(0.6)
                    })
                    .ignoresSafeArea()
            }
        }
        .frame(width: backWidth)
        .position(x: backWidth / 2.08 - positionX, y: screenSize.height / 2)
    }
}


#Preview {
    ContentView()
}

