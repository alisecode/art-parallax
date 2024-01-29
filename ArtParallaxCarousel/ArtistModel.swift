//
//  ArtistModel.swift
//  ArtParallaxCarousel
//
//  Created by Alisa Serhiienko on 26.01.2024.
//

import Foundation
import SwiftUI

struct Artist: Identifiable {
    var id = UUID()
    let title: String
    let image: String
    
    static let artists = [
        Artist(title: "Radiohead", image: "a1"),
        Artist(title: "Nina Simone", image: "a2"),
        Artist(title: "Moby", image: "a3"),
        Artist(title: "Portishead", image: "a4"),
        Artist(title: "Deftones", image: "a5")
    
    ]
}
