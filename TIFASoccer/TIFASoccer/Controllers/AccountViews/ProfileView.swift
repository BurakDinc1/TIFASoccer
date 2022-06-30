//
//  ProfileView.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 8.06.2022.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    @EnvironmentObject var baseViewModel: BaseViewModel
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    func loadFile() {
        if let inputImage = self.inputImage,
           let imageData = inputImage.pngData() {
            self.baseViewModel.loadProfileImage(imageData: imageData)
        }
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 20) {
                    HStack(alignment: .center, spacing: 20) {
                        // MARK: - Profile Picture
                        ZStack(alignment: .bottomTrailing) {
                            KFImage.url(URL(string: self.baseViewModel.userModel?.picture ?? ""))
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
                                .frame(width: 100, height: 150, alignment: .center)
                                .fillHeight()
                                .scaledToFit()
                            Image(systemName: "pencil.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25, alignment: .center)
                                .background(Color.white)
                                .foregroundColor(Color.orange)
                                .cornerRadius(25)
                                .shadow(color: Color.gray.opacity(0.5), radius: 25, x: 0, y: 0)
                        }
                        .cornerRadius(10)
                        .onTapGestureForced {
                            self.showingImagePicker = true
                        }
                        VStack(alignment: .center, spacing: 10) {
                            // MARK: - Name & Surname
                            HStack(alignment: .center, spacing: 10) {
                                Text("İsim Soyisim:")
                                    .frame(height: 15, alignment: .leading)
                                    .foregroundColor(Color.gray)
                                    .font(Font.system(size: 15))
                                Text(self.baseViewModel.userModel?.nameSurname ?? "")
                                    .frame(height: 15, alignment: .leading)
                                    .foregroundColor(Color.black)
                                    .font(Font.system(size: 13))
                                Spacer()
                            }
                            .fillWidth()
                            // MARK: - E-Mail
                            HStack(alignment: .center, spacing: 10) {
                                Text("E-Mail:")
                                    .frame(height: 15, alignment: .leading)
                                    .foregroundColor(Color.gray)
                                    .font(Font.system(size: 15))
                                Text(self.baseViewModel.userModel?.email ?? "")
                                    .frame(height: 15, alignment: .leading)
                                    .foregroundColor(Color.black)
                                    .font(Font.system(size: 13))
                                Spacer()
                            }
                            .fillWidth()
                            // MARK: - Mevki
                            HStack(alignment: .center, spacing: 10) {
                                Text("Mevki:")
                                    .frame(height: 15, alignment: .leading)
                                    .foregroundColor(Color.gray)
                                    .font(Font.system(size: 15))
                                Text(self.baseViewModel.userModel?.position ?? "")
                                    .frame(height: 15, alignment: .leading)
                                    .foregroundColor(Color.black)
                                    .font(Font.system(size: 13))
                                Spacer()
                            }
                            .fillWidth()
                            // MARK: - Rate
                            HStack(alignment: .center, spacing: 10) {
                                Text("Rate:")
                                    .frame(height: 15, alignment: .leading)
                                    .foregroundColor(Color.gray)
                                    .font(Font.system(size: 15))
                                Text(self.baseViewModel.userModel?.rate?.description ?? "")
                                    .frame(height: 15, alignment: .leading)
                                    .foregroundColor(Color.black)
                                    .font(Font.system(size: 13))
                                Spacer()
                            }
                            .fillWidth()
                        }
                        Spacer()
                    }
                    .frame(height: 150, alignment: .center)
                    .fillWidth()
                    .padding(.all, 5)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
                    .overlay(refreshButton, alignment: .topTrailing)
                    VStack(alignment: .center, spacing: 5) {
                        // MARK: - Update Profile
                        NavigationLink {
                            UpdateProfileView()
                        } label: {
                            Text("Profil Bilgilerini Güncelle")
                                .fillAll()
                                .foregroundColor(Color.black)
                                .font(Font.system(size: 15))
                                .padding()
                        }
                        Divider().padding(.horizontal)
                        // MARK: - Update Password
                        NavigationLink {
                            UpdatePasswordView()
                        } label: {
                            Text("Şifreni Güncelle")
                                .fillAll()
                                .foregroundColor(Color.black)
                                .font(Font.system(size: 15))
                                .padding()
                        }
                        Divider().padding(.horizontal)
                        // MARK: - Help
                        Text("Yardım / Hata Bildir")
                            .fillAll()
                            .foregroundColor(Color.black)
                            .font(Font.system(size: 15))
                            .padding()
                            .onTapGestureForced {
                                if let mailTo = "mailto:burak.08.44@gmail.com".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                                   let mailtoUrl = URL(string: mailTo),
                                   UIApplication.shared.canOpenURL(mailtoUrl) {
                                    UIApplication.shared.open(mailtoUrl, options: [:])
                                }
                            }
                        Divider().padding(.horizontal)
                        // MARK: - Logout
                        Text("Çıkış Yap")
                            .foregroundColor(Color.red)
                            .font(Font.system(size: 15))
                            .fillAll()
                            .padding()
                            .onTapGestureForced {
                                self.baseViewModel.signOut()
                            }
                    }
                    .padding(.all, 5)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
                }
                .padding()
            }
            .fillAll()
            if(self.baseViewModel.isLoad) {
                LoadingView()
                    .fillAll()
            }
        }
        .fillAll()
        .onAppear {
            if let currentUserID = FirebaseRepository.shared.getCurrentUserID() {
                if(self.baseViewModel.userModel == nil || self.baseViewModel.userModel?.uuid != currentUserID) {
                    self.baseViewModel.getCurrentUserData()
                }
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: self.$inputImage)
        }
        .onChange(of: self.inputImage) { _ in
            self.loadFile()
        }
    }
    
    var refreshButton: some View {
        Image(systemName: "arrow.counterclockwise.circle.fill")
            .resizable()
            .foregroundColor(.black.opacity(0.5))
            .frame(width: 25, height: 25, alignment: .center)
            .padding()
            .onTapGestureForced {
                self.baseViewModel.getCurrentUserData()
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(BaseViewModel())
    }
}
