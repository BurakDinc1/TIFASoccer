//
//  UpdatePasswordView.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 30.06.2022.
//

import SwiftUI

struct UpdatePasswordView: View {
    
    @StateObject var updatePasswordViewModel: UpdatePasswordViewModel = UpdatePasswordViewModel()
    @EnvironmentObject var baseViewModel: BaseViewModel
    
    @State var isOldPasswordValid: Bool = true
    @State var isNewPasswordValid: Bool = true
    @State var isNewPasswordRetryValid: Bool = true
    
    @State var isShowingOldPassword: Bool = false
    @State var isShowingNewPassword: Bool = false
    @State var isShowingNewPasswordRetry: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 20) {
                    // MARK: - Old Password
                    VStack(alignment: .center, spacing: 10) {
                        HStack(alignment: .center, spacing: 10) {
                            Text("Mevcut Şifre")
                                .frame(height: 15, alignment: .leading)
                                .foregroundColor(Color.gray)
                            Spacer()
                            if(!self.isOldPasswordValid) {
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
                                if(self.isShowingOldPassword) {
                                    TextField("", text: self.$updatePasswordViewModel.currentPassword)
                                        .background(Color.white)
                                        .disableAutocorrection(true)
                                        .fillAll()
                                } else {
                                    SecureField("", text: self.$updatePasswordViewModel.currentPassword)
                                        .background(Color.white)
                                        .disableAutocorrection(true)
                                        .fillAll()
                                }
                                Image(systemName: self.isShowingOldPassword ? "eye.slash" : "eye")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.gray)
                                    .frame(width: 25, height: 18)
                                    .onTapGestureForced {
                                        withAnimation {
                                            self.isShowingOldPassword.toggle()
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
                    // MARK: - Yeni Şifre
                    VStack(alignment: .center, spacing: 10) {
                        HStack(alignment: .center, spacing: 10) {
                            Text("Yeni Şifre")
                                .frame(height: 15, alignment: .leading)
                                .foregroundColor(Color.gray)
                            Spacer()
                            if(!self.isNewPasswordValid) {
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
                                if(self.isShowingNewPassword) {
                                    TextField("", text: self.$updatePasswordViewModel.newPassword)
                                        .background(Color.white)
                                        .disableAutocorrection(true)
                                        .fillAll()
                                } else {
                                    SecureField("", text: self.$updatePasswordViewModel.newPassword)
                                        .background(Color.white)
                                        .disableAutocorrection(true)
                                        .fillAll()
                                }
                                Image(systemName: self.isShowingNewPassword ? "eye.slash" : "eye")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.gray)
                                    .frame(width: 25, height: 18)
                                    .onTapGestureForced {
                                        withAnimation {
                                            self.isShowingNewPassword.toggle()
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
                    // MARK: - Yeni Şifre Tekrar
                    VStack(alignment: .center, spacing: 10) {
                        HStack(alignment: .center, spacing: 10) {
                            Text("Yeni Şifre (Tekrar)")
                                .frame(height: 15, alignment: .leading)
                                .foregroundColor(Color.gray)
                            Spacer()
                            if(!self.isNewPasswordRetryValid) {
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
                                if(self.isShowingNewPasswordRetry) {
                                    TextField("", text: self.$updatePasswordViewModel.newPasswordRetry)
                                        .background(Color.white)
                                        .disableAutocorrection(true)
                                        .fillAll()
                                } else {
                                    SecureField("", text: self.$updatePasswordViewModel.newPasswordRetry)
                                        .background(Color.white)
                                        .disableAutocorrection(true)
                                        .fillAll()
                                }
                                Image(systemName: self.isShowingNewPasswordRetry ? "eye.slash" : "eye")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.gray)
                                    .frame(width: 25, height: 18)
                                    .onTapGestureForced {
                                        withAnimation {
                                            self.isShowingNewPasswordRetry.toggle()
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
                    Text("Çok fazla başarısız deneme hesabınızın askıya alınmasına neden olacak ! Hesabınızın askıya alınması durumunda yardım talebinde bulunabilirsin.")
                        .font(Font.system(size: 12))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.gray.opacity(0.8))
                        .fillWidth()
                        .padding(.horizontal)
                    Spacer()
                }
                .padding(.vertical)
            }
            if(self.updatePasswordViewModel.isLoad) {
                LoadingView().fillAll()
            }
            if(self.updatePasswordViewModel.showAlert) {
                MessageDialog(title: "Hata !",
                              message: self.updatePasswordViewModel.errorMessage,
                              icon: .error,
                              isShow: self.$updatePasswordViewModel.showAlert)
            }
            if(self.updatePasswordViewModel.showSuccessAlert) {
                MessageDialog(title: "Başarılı 🙃",
                              message: self.updatePasswordViewModel.successMessage,
                              icon: .success,
                              isShow: self.$updatePasswordViewModel.showSuccessAlert)
            }
        }
        .fillAll()
        .navigationTitle("Şifreni Güncelle")
        .overlay(self.updateProfileButton, alignment: .bottomTrailing)
    }
    
    var updateProfileButton: some View {
        Text("Güncelle")
            .foregroundColor(Color.white)
            .font(Font.system(size: 15))
            .frame(width: 250, height: 50, alignment: .center)
            .padding(.all, 3)
            .background(LinearGradient(gradient: Gradient(colors: [.orange, .yellow, .orange]),
                                       startPoint: .leading,
                                       endPoint: .trailing))
            .cornerRadius(25, corners: .topLeft)
            .cornerRadius(25, corners: .bottomLeft)
            .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
            .padding(.vertical, 20)
            .onTapGestureForced {
                if(self.updatePasswordViewModel.currentPassword.count != 6) {
                    withAnimation {
                        self.isOldPasswordValid = false
                    }
                    return
                } else {
                    withAnimation {
                        self.isOldPasswordValid = true
                    }
                }
                if(self.updatePasswordViewModel.newPassword.count != 6) {
                    withAnimation {
                        self.isNewPasswordValid = false
                    }
                    return
                } else {
                    withAnimation {
                        self.isNewPasswordValid = true
                    }
                }
                if(self.updatePasswordViewModel.newPasswordRetry.count != 6) {
                    withAnimation {
                        self.isNewPasswordRetryValid = false
                    }
                    return
                } else {
                    withAnimation {
                        self.isNewPasswordRetryValid = true
                    }
                }
                self.updatePasswordViewModel.updatePassword()
            }
    }
}

struct UpdatePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePasswordView()
            .environmentObject(BaseViewModel())
    }
}
