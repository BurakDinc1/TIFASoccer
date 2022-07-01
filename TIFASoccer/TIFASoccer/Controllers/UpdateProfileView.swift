//
//  UpdateProfileView.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 29.06.2022.
//

import SwiftUI

struct UpdateProfileView: View {
    
    @StateObject var updateProfileViewModel: UpdateProfileViewModel = UpdateProfileViewModel()
    @EnvironmentObject var baseViewModel: BaseViewModel
    
    @State var isNameValid: Bool = true
    @State var isMailValid: Bool = true
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 20) {
                    // MARK: - Name & Surname
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
                            TextField("", text: self.$updateProfileViewModel.nameSurname)
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
                    // MARK: - Position
                    Menu {
                        ForEach(Mevki.allCases, id: \.rawValue) { mevki in
                            Button {
                                self.updateProfileViewModel.position = mevki.rawValue
                            } label: {
                                Text(mevki.rawValue)
                                Image(systemName: mevki.rawValue.getPositionImageName())
                            }
                        }
                    } label: {
                        VStack(alignment: .center, spacing: 10) {
                            HStack(alignment: .center, spacing: 10) {
                                Text("Pozisyon")
                                    .frame(height: 15, alignment: .leading)
                                    .foregroundColor(Color.gray)
                                Spacer()
                            }
                            HStack(alignment: .center, spacing: 10) {
                                Text(self.updateProfileViewModel.position)
                                    .foregroundColor(Color.black)
                                Spacer()
                                Image(systemName: "arrow.down")
                                    .foregroundColor(Color.black)
                            }
                            .frame(height: 50, alignment: .center)
                            .padding(.horizontal, 10)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
                        }
                        .fillWidth()
                        .padding(.horizontal)
                    }
                    Spacer()
                }
                .padding(.vertical)
            }
            if(self.updateProfileViewModel.isLoad) {
                LoadingView().fillAll()
            }
            if(self.updateProfileViewModel.showAlert) {
                MessageDialog(title: "Hata !",
                              message: self.updateProfileViewModel.errorMessage,
                              icon: .error,
                              isShow: self.$updateProfileViewModel.showAlert)
            }
            if(self.updateProfileViewModel.showSuccessAlert) {
                MessageDialog(title: "Başarılı 🙃",
                              message: self.updateProfileViewModel.successMessage,
                              icon: .success,
                              isShow: self.$updateProfileViewModel.showSuccessAlert)
            }
        }
        .fillAll()
        .navigationTitle("Profilini Güncelle")
        .overlay(self.updateProfileButton, alignment: .bottomTrailing)
        .onAppear {
            self.updateProfileViewModel.position = self.baseViewModel.userModel?.position ?? Mevki.joker.rawValue
            self.updateProfileViewModel.nameSurname = self.baseViewModel.userModel?.nameSurname ?? ""
        }
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
                if(self.updateProfileViewModel.nameSurname.count == 3) {
                    withAnimation {
                        self.isNameValid = false
                    }
                    return
                } else {
                    withAnimation {
                        self.isNameValid = true
                    }
                }
                self.updateProfileViewModel.updatePlayerData()
            }
    }
    
}

struct UpdateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProfileView()
            .environmentObject(BaseViewModel())
    }
}
