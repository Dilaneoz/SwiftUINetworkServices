//
//  NetworkService.swift
//  NetworkServiceSwiftUI
//
//  Created by Atil Samancioglu on 14.08.2022.
//

import Foundation
// hem localservice hem de webservice imiz bu NetworkService e uyum sağlayacak
protocol NetworkService {
    func download(_ resourceName: String) async throws -> [User] // bu protokulü uygulayan herkes bundan sonra bu fonksiyonu uygulamak zorunda. webservice te bu protokolü uyguladığımızda hiçbi sorun çıkmaz çünkü aynı fonksiyon kullanılır. orada fonksiyonun adına başka bi şey yazsak hata çıkardı
    var type : String { get }
}
