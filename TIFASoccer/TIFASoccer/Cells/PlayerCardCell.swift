//
//  PlayerCardCell.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 10.06.2022.
//

import SwiftUI
import Kingfisher

struct PlayerCardCell: View {
    
    @State var isFlipped: Bool = false
    @Binding var user: UserModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            if (!self.isFlipped) {
                if let pictureString = self.user.picture {
                    KFImage.url(URL(string: pictureString))
                        .resizable()
                        .placeholder({
                            LoadingView()
                                .frame(height: 240, alignment: .center)
                                .fillWidth()
                        })
                        .loadDiskFileSynchronously()
                        .cacheMemoryOnly()
                        .fade(duration: 0.25)
                        .onProgress { receivedSize, totalSize in  }
                        .onSuccess { result in  }
                        .onFailure { error in }
                        .fillAll()
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
            } else {
                if let userPosition = self.user.position {
                    VStack(alignment: .center, spacing: 10) {
                        Image(systemName: userPosition.getPositionImageName())
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50, alignment: .center)
                        Text(userPosition)
                            .foregroundColor(.black)
                            .font(Font.system(size: 20).bold())
                    }
                    .fillAll()
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 0.0, y: 1.0, z: 0.0))
                }
            }
        }
        .fillWidth()
        .frame(height: 300, alignment: .center)
        .padding(.all, 10)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
        .rotation3DEffect(
            self.isFlipped ? Angle(degrees: 180) : .zero,
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
        .animation(.default, value: self.isFlipped)
        .onTapGestureForced {
            self.isFlipped.toggle()
        }
    }
}

struct PlayerCardCell_Previews: PreviewProvider {
    static var previews: some View {
        PlayerCardCell(user: .constant(UserModel(dictionary: [:])))
    }
}
