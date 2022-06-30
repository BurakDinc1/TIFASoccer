//
//  PlayerCardCell.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 10.06.2022.
//

import SwiftUI
import Kingfisher

struct PlayerCardCell: View {
    
    @Binding var user: UserModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            if let pictureString = self.user.picture {
                KFImage.url(URL(string: pictureString))
                    .resizable()
                    .placeholder({
                        LoadingView()
                            .fillAll()
                    })
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .fade(duration: 0.25)
                    .onProgress { receivedSize, totalSize in  }
                    .onSuccess { result in  }
                    .onFailure { error in }
                    .fillWidth()
                    .frame(height: 250, alignment: .center)
                    .scaledToFit()
            }
            if let nameSurname = self.user.nameSurname,
               let rate = self.user.rate {
                Text(nameSurname)
                    .foregroundColor(Color.black)
                    .font(Font.system(size: 15))
                    .fillWidth()
                    .padding(.horizontal)
                RatingView(rating: CGFloat(rate), maxRating: 5)
                    .frame(height: 15, alignment: .center)
                    .fillWidth()
                    .padding(.bottom, 5)
            }
        }
        .fillWidth()
        .padding(.all, 10)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
    }
}

struct PlayerCardCell_Previews: PreviewProvider {
    static var previews: some View {
        PlayerCardCell(user: .constant(UserModel(dictionary: [:])))
    }
}
