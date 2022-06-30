//
//  CommentCell.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 24.06.2022.
//

import SwiftUI
import Kingfisher

struct CommentCell: View {
    
    @State var comment: CommentsModel
    
    var body: some View {
        ZStack {
            Image("football_area_cartoon")
                .resizable()
                .scaledToFill()
                .fillAll()
                .blur(radius: 5)
            HStack(alignment: .center, spacing: 0) {
                VStack {
                    Image("default_user")
                        .resizable()
                        .frame(width: 50, height: 50,alignment: .center)
                        .scaledToFit()
                    Spacer()
                }
                VStack(alignment: .center, spacing: 5) {
                    HStack(alignment: .center, spacing: 0) {
                        Text("Anonim")
                            .foregroundColor(Color.white)
                            .font(Font.system(size: 13))
                        Spacer()
                    }
                    .padding(.horizontal)
                    if let comment = self.comment.comment {
                        HStack(alignment: .center, spacing: 0) {
                            Text(comment)
                                .foregroundColor(Color.white)
                                .font(Font.system(size: 16))
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    Spacer()
                    if let date = self.comment.date {
                        HStack(alignment: .center, spacing: 0) {
                            Spacer()
                            Text(date)
                                .foregroundColor(Color.white)
                                .font(Font.system(size: 13))
                        }
                        .padding(.horizontal)
                    }
                }
                .fillAll()
            }
            .padding()
            .fillAll()
        }
        .fillWidth()
        .frame(height: 150, alignment: .center)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
        .padding(.horizontal)
        .padding(.vertical, 3)
    }
}

struct CommentCell_Previews: PreviewProvider {
    static var previews: some View {
        CommentCell(comment: CommentsModel(dictionary: [:]))
    }
}
