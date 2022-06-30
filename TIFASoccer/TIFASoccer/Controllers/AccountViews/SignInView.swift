//
//  SignInView.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 8.06.2022.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var baseViewModel: BaseViewModel
    
    @State var isValidEmail: Bool = true
    @State var isValidPassword: Bool = true
    @State var email: String = ""
    @State var password: String = ""
    @State var isShowingPassword: Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                Text("Giriş Yap")
                    .font(Font.system(size: 25))
                VStack(alignment: .center, spacing: 10) {
                    HStack(alignment: .center, spacing: 10) {
                        Text("E-Mail")
                            .frame(height: 15, alignment: .leading)
                            .foregroundColor(Color.gray)
                        Spacer()
                        if(!self.isValidEmail) {
                            HStack(alignment: .center, spacing: 10) {
                                Text("Lütfen geçerli bir e-mail adresi giriniz !")
                                    .frame(height: 15, alignment: .center)
                                    .font(Font.system(size: 12))
                                    .foregroundColor(Color.red)
                                Image(systemName: "info.circle.fill")
                                    .resizable()
                                    .frame(width: 15, height: 15, alignment: .center)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    HStack(alignment: .center, spacing: 10) {
                        TextField("", text: self.$email)
                            .background(Color.white)
                            .disableAutocorrection(true)
                            .fillAll()
                    }
                    .frame(height: 50, alignment: .center)
                    .padding(.horizontal, 10)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
                }
                .fillWidth()
                .padding(.horizontal)
                VStack(alignment: .center, spacing: 10) {
                    HStack(alignment: .center, spacing: 10) {
                        Text("Şifre")
                            .frame(height: 15, alignment: .leading)
                            .foregroundColor(Color.gray)
                        Spacer()
                        if(!self.isValidPassword) {
                            HStack(alignment: .center, spacing: 10) {
                                Text("Lütfen geçerli bir şifre giriniz !")
                                    .frame(height: 15, alignment: .center)
                                    .font(Font.system(size: 12))
                                    .foregroundColor(Color.red)
                                Image(systemName: "info.circle.fill")
                                    .resizable()
                                    .frame(width: 15, height: 15, alignment: .center)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    ZStack(alignment: .center) {
                        HStack(alignment: .center, spacing: 10) {
                            if(self.isShowingPassword) {
                                TextField("", text: self.$password)
                                    .background(Color.white)
                                    .disableAutocorrection(true)
                                    .fillAll()
                            } else {
                                SecureField("", text: self.$password)
                                    .background(Color.white)
                                    .disableAutocorrection(true)
                                    .fillAll()
                            }
                            Image(systemName: self.isShowingPassword ? "eye.slash" : "eye")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.gray)
                                .frame(width: 25, height: 18)
                                .onTapGestureForced {
                                    withAnimation {
                                        self.isShowingPassword.toggle()
                                    }
                                }
                        }
                        .fillAll()
                    }
                    .frame(height: 50, alignment: .center)
                    .padding(.horizontal, 10)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
                }
                .fillWidth()
                .padding(.horizontal)
                Button {
                    if(!self.email.isValidEmail()) {
                        withAnimation {
                            self.isValidEmail = false
                        }
                        return
                    } else {
                        withAnimation {
                            self.isValidEmail = true
                        }
                    }
                    if(self.password.count < 6) {
                        withAnimation {
                            self.isValidPassword = false
                        }
                        return
                    } else {
                        withAnimation {
                            self.isValidPassword = true
                        }
                    }
                    self.baseViewModel.login(email: self.email, password: self.password)
                } label: {
                    Text("Giriş Yap")
                        .frame(height: 50, alignment: .center)
                        .fillWidth()
                        .background(LinearGradient(gradient: Gradient(colors: [.orange, .yellow, .orange]),
                                                   startPoint: .leading,
                                                   endPoint: .trailing))
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
                        .foregroundColor(Color.white)
                }
                .padding(.horizontal)
                Text("veya")
                    .foregroundColor(Color.gray)
                    .frame(height: 25, alignment: .center)
                Text("Kayıt Ol")
                    .foregroundColor(Color.orange)
                    .font(Font.system(size: 15))
                    .frame(height: 50, alignment: .center)
                    .fillWidth()
                    .onTapGestureForced {
                        withAnimation {
                            self.baseViewModel.isRegisterViewShowing.toggle()
                        }
                    }
            }
            .padding(.vertical)
        }
        .fillAll()
        .padding()
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(BaseViewModel())
    }
}
