//
//  AccountView.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 8.06.2022.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var baseViewModel: BaseViewModel
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                if(self.baseViewModel.isLoggedIn) {
                    ProfileView()
                } else {
                    if(self.baseViewModel.isRegisterViewShowing) {
                        RegisterView()
                    } else {
                        SignInView()
                    }
                }
                if(self.baseViewModel.isLoad) {
                    LoadingView()
                        .fillAll()
                }
                if(self.baseViewModel.showAlert) {
                    MessageDialog(title: "Hata !",
                                  message: self.baseViewModel.errorMessage,
                                  icon: .error,
                                  isShow: self.$baseViewModel.showAlert)
                }
            }
            .navigationTitle(self.baseViewModel.getNavigationTitleForBaseView())
            .overlay(self.devByDNC, alignment: .bottom)
        }
    }
    
    var devByDNC: some View {
        Text("Dev by DNC")
            .foregroundColor(Color.gray)
            .font(Font.system(size: 11))
            .fillWidth()
            .padding(5)
            .background(Color.white)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .environmentObject(BaseViewModel())
    }
}
