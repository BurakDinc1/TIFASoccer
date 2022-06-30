//
//  CommentsView.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 23.06.2022.
//

import SwiftUI
import Combine

struct CommentsView: View {
    
    @EnvironmentObject var matchsViewModel: MatchsViewModel
    @Binding var comments: [CommentsModel]
    @State var commentText: String = ""
    @State var characterLimit: Int = 100
    @State var limitText: String = "100"
    
    // Function to keep text length in limits
    func limitText(_ upper: Int) {
        if self.commentText.count > upper {
            self.commentText = String(self.commentText.prefix(upper))
        }
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            VStack(alignment: .center, spacing: 10) {
                HStack(alignment: .center, spacing: 10) {
                    Text("Yorumlar")
                        .font(Font.system(.largeTitle))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    Spacer()
                }
                ForEach(self.comments, id: \.uuid) { comment in
                    CommentCell(comment: comment)
                }
                HStack(alignment: .top, spacing: 10) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(AngularGradient(gradient: Gradient(colors: [.orange, .yellow, .orange, .yellow, .orange]),
                                                    center: .center,
                                                    startAngle: .zero,
                                                    endAngle: .degrees(360)),
                                    lineWidth: 3)
                        HStack(alignment: .center, spacing: 10) {
                            TextField("Maç hakkında bir yorum gönderin 🙃", text: self.$commentText)
                                .padding()
                                .multilineTextAlignment(.leading)
                                .background(Color.clear)
                                .font(Font.system(size: 14))
                                .onReceive(Just(self.commentText)) { _ in limitText(self.characterLimit) }
                            Text(self.limitText)
                                .font(Font.system(size: 14))
                                .padding(.trailing)
                        }
                    }
                    .fillAll()
                    Image(systemName: "paperplane")
                        .frame(width: 50, height: 50, alignment: .center)
                        .background(AngularGradient(gradient: Gradient(colors: [.orange, .yellow, .orange, .yellow, .orange]),
                                                    center: .center,
                                                    startAngle: .zero,
                                                    endAngle: .degrees(360)))
                        .cornerRadius(25)
                        .foregroundColor(Color.white)
                        .shadow(color: Color.gray.opacity(0.5), radius: 25, x: 0, y: 0)
                        .onTapGestureForced {
                            self.matchsViewModel.addComment(comment: self.commentText)
                        }
                }
                .fillWidth()
                .frame(height: 50, alignment: .center)
                .padding()
            }
            .padding(.vertical)
        }
        .onChange(of: self.commentText) { newValue in
            self.limitText = (self.characterLimit - newValue.count).description
        }
    }
}

// MARK: - Preview
struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView(comments: .constant([]))
            .environmentObject(MatchsViewModel())
    }
}
