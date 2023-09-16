//
//  Constants.swift
//  NetworkServiceSwiftUI
//
//  Created by Atil Samancioglu on 14.08.2022.
//

import Foundation

struct Constants {
    
    //https://raw.githubusercontent.com/atilsamancioglu/UsersJSONPlaceHolder/main/users.json
    //https://jsonplaceholder.typicode.com/users
    
    struct Paths {
        static let baseUrl = "users" // burada sadece users ı vermek lazım çünkü localservice te diyoruz ki buradaki resource u bundle.main.path ten al resource sana users olarak gelicek ve sonunda users.json ı ara diyoruz. users ı vermez başka bişi verirsek bulamaz. o yüzden artık localservice seçildiyse baseUrl bunu vermek, webservice seçildiyse usersExtension bunu vermeyi istiycez
    }
    
    struct Urls {
        static let baseUrl = "https://jsonplaceholder.typicode.com" // static let her yerden erişebileceğimiz bi değişken oluşturur. bunu singleton olarak da yapabilirdik ama çok kasmaya gerek yok
        static let usersExtension = "\(baseUrl)/users"
    }
    
    
}
