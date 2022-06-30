//
//  RegisterView.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 8.06.2022.
//

import SwiftUI

struct RegisterView: View {
    
    @EnvironmentObject var baseViewModel: BaseViewModel
    
    @State var email: String = ""
    @State var nameSurname: String = ""
    @State var password: String = ""
    @State var passwordRetry: String = ""
    @State var isPasswordValid: Bool = true
    @State var isPasswordRetryValid: Bool = true
    @State var isEmailValid: Bool = true
    @State var isNameValid: Bool = true
    @State var isShowingPassword: Bool = false
    @State var isShowingPasswordRetry: Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                Text("Kayıt Ol")
                    .font(Font.system(size: 25))
                VStack(alignment: .center, spacing: 10) {
                    HStack(alignment: .center, spacing: 10) {
                        Text("E-Mail")
                            .frame(height: 15, alignment: .leading)
                            .foregroundColor(Color.gray)
                        Spacer()
                        if(!self.isEmailValid) {
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
                        Text("İsim Soyisim")
                            .frame(height: 15, alignment: .leading)
                            .foregroundColor(Color.gray)
                        Spacer()
                        if(!self.isNameValid) {
                            HStack(alignment: .center, spacing: 10) {
                                Text("Lütfen geçerli bir isim giriniz !")
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
                        TextField("", text: self.$nameSurname)
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
                        if(!self.isPasswordValid) {
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
                VStack(alignment: .center, spacing: 10) {
                    HStack(alignment: .center, spacing: 10) {
                        Text("Şifre (Tekrar)")
                            .frame(height: 15, alignment: .leading)
                            .foregroundColor(Color.gray)
                        Spacer()
                        if(!self.isPasswordRetryValid) {
                            HStack(alignment: .center, spacing: 10) {
                                Text("Şifreler eşleşmiyor !")
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
                            if(self.isShowingPasswordRetry) {
                                TextField("", text: self.$passwordRetry)
                                    .background(Color.white)
                                    .disableAutocorrection(true)
                                    .fillAll()
                            } else {
                                SecureField("", text: self.$passwordRetry)
                                    .background(Color.white)
                                    .disableAutocorrection(true)
                                    .fillAll()
                            }
                            Image(systemName: self.isShowingPasswordRetry ? "eye.slash" : "eye")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.gray)
                                .frame(width: 25, height: 18)
                                .onTapGestureForced {
                                    withAnimation {
                                        self.isShowingPasswordRetry.toggle()
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
                            self.isEmailValid = false
                        }
                        return
                    } else {
                        withAnimation {
                            self.isEmailValid = true
                        }
                    }
                    if(self.nameSurname.count == 3) {
                        withAnimation {
                            self.isEmailValid = false
                        }
                        return
                    } else {
                        withAnimation {
                            self.isEmailValid = true
                        }
                    }
                    if(self.password.count != 6) {
                        withAnimation {
                            self.isPasswordValid = false
                        }
                        return
                    } else {
                        withAnimation {
                            self.isPasswordValid = true
                        }
                    }
                    if(self.password != self.passwordRetry) {
                        withAnimation {
                            self.isPasswordRetryValid = false
                        }
                        return
                    } else {
                        withAnimation {
                            self.isPasswordRetryValid = true
                        }
                    }
                    self.baseViewModel.register(email: self.email, password: self.password, nameSurname: self.nameSurname)
                } label: {
                    Text("Kayıt Ol")
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
                Text("Giriş Yap")
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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .environmentObject(BaseViewModel())
    }
}
