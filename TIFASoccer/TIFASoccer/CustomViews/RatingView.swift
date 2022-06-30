//
//  RatingView.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 10.06.2022.
//

import SwiftUI

// https://stackoverflow.com/questions/64379079/how-to-present-accurate-star-rating-using-swiftui
struct RatingView: View {
    
    var rating: CGFloat
    var maxRating: Int
    
    var body: some View {
        let stars = HStack(spacing: 0) {
            ForEach(0..<maxRating) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        
        stars.overlay(
            GeometryReader { g in
                let width = rating / CGFloat(maxRating) * g.size.width
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width)
                        .foregroundColor(.yellow)
                }
            }
                .mask(stars)
        )
            .foregroundColor(Color.gray)
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: 3, maxRating: 5)
    }
}
