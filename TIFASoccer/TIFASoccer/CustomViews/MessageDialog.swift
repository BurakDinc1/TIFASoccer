//
//  MessageDialog.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 16.06.2022.
//

import SwiftUI

enum MessageDialogIconType: String {
    case success = "checkmark.circle"
    case error = "xmark.circle"
}

struct MessageDialog: View {
    
    @State var title: String = ""
    @State var message: String = ""
    @State var icon: MessageDialogIconType = .error
    /// showAlert boolean degeri kapanir.
    @Binding var isShow: Bool
    
    var body: some View {
        ZStack {
            Color.white
                .opacity(0.5)
                .blur(radius: 10)
            VStack(alignment: .center, spacing: 0) {
                ZStack {
                    VStack(spacing: 0) {
                        Color.clear.fillWidth().frame(height: 40)
                        Color.white.fillWidth().frame(height: 40)
                            .cornerRadius(10, corners: [.topLeft, .topRight])
                    }
                    Image(systemName: self.icon.rawValue)
                        .renderingMode(.template)
                        .resizable()
                        .padding()
                        .foregroundColor(.white)
                        .setCircleWithBackground(widthAndHeight: 80,
                                                 backgroundColor: Color.orange)
                }
                .background(Color.clear)
                .fillWidth()
                VStack(alignment: .leading, spacing: 20) {
                    Text(self.title)
                        .foregroundColor(Color.black)
                        .font(Font.custom("DMSans-Regular", size: 20))
                        .fillWidth()
                        .padding(.top, 10)
                    Text(self.message)
                        .foregroundColor(Color.gray)
                        .font(Font.custom("DMSans-Regular", size: 15))
                        .multilineTextAlignment(.center)
                        .padding(.leading)
                        .padding(.trailing)
                        .fillWidth()
                    Button {
                        self.isShow = false
                    } label: {
                        HStack(alignment: .center, spacing: 20) {
                            Text("Tamam")
                                .foregroundColor(Color.white)
                                .font(Font.custom("DMSans-Regular", size: 16))
                        }
                        .padding()
                        .fillWidth()
                    }
                    .background(Color.orange)
                    .fillWidth()
                }
                .background(Color.white)
            }
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.5), radius: 10)
            .background(Color.clear)
            .frame(width: UIScreen.main.bounds.width - 75, alignment: .center)
            .transition(.asymmetric(insertion: .scale, removal: .opacity))
        }
        .fillAll()
    }
}

struct MessageDialog_Previews: PreviewProvider {
    static var previews: some View {
        MessageDialog(title: "Title",
                      message: "Lorem ipsum.",
                      isShow: .constant(false))
    }
}
