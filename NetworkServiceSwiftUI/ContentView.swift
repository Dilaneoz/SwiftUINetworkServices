//
//  ContentView.swift
//  NetworkServiceSwiftUI
//
//  Created by Atil Samancioglu on 14.08.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var userListViewModel : UserListViewModel
    
    init() {
        self.userListViewModel = UserListViewModel(service: Localservice()) // protokol kullanmak bu yüzden iyi buraya ister webservice ister localservice yazabiliriz. localservice te bi networkservice webservice te bi networkservice. 
    }
    
    var body: some View { // list in içinde userListViewModel.userList i göstericez
        List(userListViewModel.userList,id: \.id) { user in
            VStack { // her bir kullanıcı gösterilecek
                Text(user.name)
                    .font(.title3)
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity, alignment:.leading) // maxWidth: .infinity bu en fazla ne kadar genişlik olucağını sorar doldurabileceğin kadar doldur diyoruz. alignment:.leading bu da en soldan başlat demek
                Text(user.username)
                    .foregroundColor(.green)
                    .frame(maxWidth: .infinity, alignment:.leading)
                Text(user.email)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment:.leading)
            }
        }.task {
            await userListViewModel.downloadUsers() // async olduğu için başına await koyuyoruz
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
