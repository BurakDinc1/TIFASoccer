//
//  CreateMatchView.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 14.06.2022.
//

import SwiftUI

struct CreateMatchView: View {
    
    @StateObject var createMatchViewModel: CreateMatchViewModel = CreateMatchViewModel()
    @Environment(\.presentationMode) var presentation
    @Binding var isRefreshMatchsView: Bool
    
    @State var isEmptyFootballArea: Bool = true
    @State var isEmptyAdminMessage: Bool = true

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack(alignment: .center) {
                VStack(alignment: .center, spacing: 20) {
                    DatePicker(selection: self.$createMatchViewModel.matchStartDate) {
                        Text("Maçın Başlama Zamanı:")
                            .foregroundColor(.gray)
                            .font(Font.system(size: 15))
                    }
                    DatePicker(selection: self.$createMatchViewModel.matchFinishDate) {
                        Text("Maçın Bitiş Zamanı:")
                            .foregroundColor(.gray)
                            .font(Font.system(size: 15))
                    }
                    VStack(alignment: .center, spacing: 10) {
                        HStack {
                            Text("Halı Saha:")
                                .foregroundColor(.gray)
                                .font(Font.system(size: 15))
                            Spacer()
                            if(!self.isEmptyFootballArea) {
                                HStack(alignment: .center, spacing: 10) {
                                    Text("Lütfen bu alanı doldurunuz !")
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
                        .fillWidth()
                        ZStack(alignment: .center) {
                            TextField("", text: self.$createMatchViewModel.footballArea)
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
                    VStack(alignment: .center, spacing: 10) {
                        HStack {
                            Text("Açıklama:")
                                .foregroundColor(.gray)
                                .font(Font.system(size: 15))
                            Spacer()
                            if(!self.isEmptyAdminMessage) {
                                HStack(alignment: .center, spacing: 10) {
                                    Text("Lütfen bu alanı doldurunuz !")
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
                        .fillWidth()
                        ZStack(alignment: .center) {
                            TextEditor(text: self.$createMatchViewModel.adminMessage)
                                .background(Color.white)
                                .disableAutocorrection(true)
                                .fillAll()
                        }
                        .frame(height: 150, alignment: .center)
                        .padding(.horizontal, 10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
                    }
                    Spacer()
                }
                .fillWidth()
                .padding()
                if(self.createMatchViewModel.isLoad) {
                    LoadingView().fillAll()
                }
                if(self.createMatchViewModel.showAlert) {
                    MessageDialog(title: "Hata !",
                                  message: self.createMatchViewModel.errorMessage,
                                  icon: .error,
                                  isShow: self.$createMatchViewModel.showAlert)
                }
            }
            .fillAll()
        }
        .fillAll()
        .navigationTitle("Maç Oluştur")
        .overlay(self.createMatchButton, alignment: .bottomTrailing)
        .onChange(of: self.createMatchViewModel.isShowingCreateMatchView) { newValue in
            if(!newValue) {
                self.isRefreshMatchsView = true
                self.presentation.wrappedValue.dismiss()
            } else {
                self.isRefreshMatchsView = false
            }
        }
    }
    
    var createMatchButton: some View {
        Text("Oluştur")
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
                if(self.createMatchViewModel.footballArea.isEmpty) {
                    withAnimation {
                        self.isEmptyFootballArea = false
                    }
                    return
                } else {
                    withAnimation {
                        self.isEmptyFootballArea = true
                    }
                }
                if(self.createMatchViewModel.adminMessage.isEmpty) {
                    withAnimation {
                        self.isEmptyAdminMessage = false
                    }
                    return
                } else {
                    withAnimation {
                        self.isEmptyAdminMessage = true
                    }
                }
                self.createMatchViewModel.createMatch()
            }
    }
    
}

struct CreateMatchView_Previews: PreviewProvider {
    static var previews: some View {
        CreateMatchView(isRefreshMatchsView: .constant(false))
    }
}
