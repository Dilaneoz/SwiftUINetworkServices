//
//  Webservice.swift
//  NetworkServiceSwiftUI
//
//  Created by Atil Samancioglu on 14.08.2022.
//

import Foundation

// bu webservisi sadece webservise olarak tutmak istemiyoruz. diğer kısımlara da eklemek istiyoruz localservice gibi ve istediğimizde sadece tek bir satır şeyi değiştirerek kullanmak istiyoruz. bu projeyi yapma amacımız buydu

enum NetworkError : Error { // hata protokolüne uygun bi enum
    case invalidUrl // url yi yanlış yazdık
    case invalidServerResponse // url yi doğru yazdık ama sunucudan yanlış cevap geldi belki internet yok ya da url geçerli ama url yi yanlış yazdık
}

class Webservice : NetworkService {
    var type: String = "Webservice" // bunu oluşturuyoruz çünkü UserViewModel da kullanıcaz
    
    func download(_ resource: String) async throws -> [User] { // url yi resource olarak isteme sebebi, local webservice i yazmaya çalıştığımızda orada da bi download fonksiyonu olucak ve o local den json dosyamızı okuycak ama sonuçta ona da bi url vermemiz lazım. en azından json dosyasını nereye koyduğumuzu söylememiz lazım. ona da bi string vericez. bu url olucak onunki path olucak ama olsun url olarak verelim ki ya da en azından bu fonksiyonun içerisinde isteyelim ki sonra hemen hemen aynı fonksiyonu kullanarak, sadece içeriğini değiştirerek, bu işlemi başarıyla tamamlayabilelim
        
        
        guard let url = URL(string: resource) else { // url yi oluşturabiliyosan devam et
            throw NetworkError.invalidUrl // oluşturamıyosan hata ver
        }
         
        /*
        guard let url = Constants.UserResources.resource(for: resource) else {
            throw NetworkError.invalidUrl
        }
         */
        
        let (data, response) = try await URLSession.shared.data(from: url) // datayı alıyoruz. async await kullandığımız için datatask i değil data yı kullanıyoruz. bu data bize bi veri bi de cevap döndürücek o yüzden bi değişkene eşitliyoruz. async olduğu için await yazıyoruz
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { // veriyi aldık şimdi response u inceliyoruz. HTTPURLResponse olarak bunu alabilirsek statusCode u kontrol edebiliriz. 200 gelmesi okey sunucudan cevap aldığımız anlamına gelir
                throw NetworkError.invalidServerResponse // 200 gelmezse hata döncek
        }
        
        return try JSONDecoder().decode([User].self, from: data) // veriyi aldıktan sonra decode ediyoruz ve user ı dönüyoruz
    }
    
}
