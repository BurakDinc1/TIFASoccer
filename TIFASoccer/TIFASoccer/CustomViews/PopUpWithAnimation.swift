//
//  PopUpWithAnimation.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 16.06.2022.
//

import SwiftUI
import Lottie

struct PopUpWithAnimation: View {
    
    @Binding var isShowing: Bool
    
    @State var lottieName: String
    @State var title: String
    @State var message: String
    @State var buttonTitle: String
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.1)
            VStack(spacing: 12) {
                LottieView(name: self.lottieName, loopMode: .loop)
                    .frame(maxWidth: 226, maxHeight: 226)
                Text(self.title)
                    .foregroundColor(.black)
                    .font(.system(size: 24))
                    .padding(.top, 12)
                Text(self.message)
                    .foregroundColor(.black)
                    .font(.system(size: 16))
                    .opacity(0.6)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                Text(self.buttonTitle)
                    .foregroundColor(Color.white)
                    .frame(height: 50, alignment: .center)
                    .fillWidth()
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(LinearGradient(gradient: Gradient(colors: [.orange, .yellow, .orange]),
                                               startPoint: .leading,
                                               endPoint: .trailing))
                    .cornerRadius(12)
                    .onTapGestureForced {
                        self.isShowing = false
                    }
            }
            .padding(EdgeInsets(top: 37, leading: 24, bottom: 40, trailing: 24))
            .background(Color.white.cornerRadius(20))
            .padding(.horizontal, 40)
            .shadow(color: Color.black.opacity(0.5), radius: 12, x: 0, y: 0)
        }
        .fillAll()
    }
}

struct PopUpWithAnimation_Previews: PreviewProvider {
    static var previews: some View {
        PopUpWithAnimation(isShowing: .constant(false),
                           lottieName: "",
                           title: "",
                           message: "",
                           buttonTitle: "")
    }
}
