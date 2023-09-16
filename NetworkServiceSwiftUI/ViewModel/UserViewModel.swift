//
//  UserViewModel.swift
//  NetworkServiceSwiftUI
//
//  Created by Atil Samancioglu on 14.08.2022.
//

import Foundation
// webservice te yazdıklarımızı burada kullanıcaz
class UserListViewModel : ObservableObject { // contentview içinde kullanıcağımız sınıf. class olarak oluşturma sebebi ObservableObject tan inheritance alıcak olması. ObservableObject yapma sebebimiz, aşağıda bi @Published var oluşturuyoduk, bu yayın yaptığı için contentviewda bu published i gözlemlediğimizde değişiklik olduğunda bu değişken içerisinde arayüzü de değiştirebilmek
    
    @Published var userList = [UserViewModel]() // userList kullanıcıları içinde tuttuğumuz liste. internetten indirdiğimiz şeyleri buraya UserViewModel olarak kaydedicez
    
    //let webservice = Webservice()
    private var service : NetworkService // webservice mi localservice mi veriyoruz farketmez dediğimi için böyle oluşturuyoruz
    init(service: NetworkService) { // init yapıp service i istiyoruz çünkü bunu kullanırken direkt burada oluşturmıycaz contentview içinde tek bi şeyi değiştirerek erişebilicez
        // böylelikle artık UserViewModel oluşturulurken bizden bir service istenicek ve biz network u mu kullanmak istiyoruz yoksa local i mi orada karar vericez 
        self.service = service
    }
    
    func downloadUsers() async { // download u kullanabilmek için async olması gerekiyor bu fonksiyonun
        
        var resource = ""
        
        if service.type == "Webservice" { // servis tipi Webservice ise
            resource = Constants.Urls.usersExtension // bunu yap
        } else { // localservice ise
            resource = Constants.Paths.baseUrl // bunu yap. böylelikle local seçiliyoken path i, webservice kullanılıyoken url yi kullanabiliriz
        }
        do {
            let users = try await service.download(resource) // endustride download içine direkt url koyulmaz bu şekilde yapılır. bi constants klasörü oluşturulur bunun içine sabitler koyulur

            DispatchQueue.main.async {
                self.userList = users.map(UserViewModel.init) // user ları UserViewModel a çevirmek için map kullanıyoruz
            }
        } catch {
            print(error)
        }
    }
}

// userModel da aldığımız ve decode ettiğimiz işlemi ayrı bi viewmodel yapısına çevirmek istiyoruz sonra yukarıda kullanıcaz
struct UserViewModel {
    // sadece ekranda kullanıcağımız bilgileri alıyoruz
    let user : User
    
    var id : Int {
        user.id
    }
    
    var name : String {
        user.name
    }
    
    var username : String {
        user.username
    }
    
    var email: String {
        user.email
    }
}

