//
//  Localservice.swift
//  NetworkServiceSwiftUI
//
//  Created by Atil Samancioglu on 14.08.2022.
//

import Foundation

// users klasörüne json dosyasını ekledik. webservice ile internetten okurken localservice ile de bu projeye eklediğimiz json dosyasından okumak istiyoruz
// localservice de webservice e benzer şekilde oluşturulur
// webservice teki gibi veriyi okumak ve sonra decode etmek gerekiyor. peki veriyi nasıl okuycaz? öncelikle bize bi string verilecek yani şu url ye git gibisinden. bunun adını users.json koyduk. users.json koyma sebebi, istek attığımız yerin adı da users, aynı ismi koyduk ki hep aynı stringleri kullanabilelim. böylelikle esas amaç sadece bi satır şeyi değiştirmek olduğu için ona erişebilmek
// webservice ten farkı urlsession ile internete istek atmak yerine, kendi local imizden okuyoruz
// lokal kullanmanın faydaları users.json dosyasında istediğimiz değişikliği yapabiliriz, usermodeli ona göre değiştirebiliriz
class Localservice : NetworkService {
    
    var type: String = "Localservice" // bunu oluşturuyoruz çünkü UserViewModel da kullanıcaz

    func download(_ resource: String) async throws -> [User] { // fonksiyonun adını webservice tekiyle aynı kullanmak daha iyidir çünkü NetworkService te bi protokol oluşturduk ve içinde download fonksiyonu var. o protocol burada ve webservice te kullanılıyor o yüzden aynı fonksiyon ismi girilmek zorunda
        
        guard let path = Bundle.main.path(forResource: resource, ofType: "json") else { // users.json böyle okunuyor. bu path, users.json a giden path aslında. bundle bizim com.dilansuozturk.networkservice gibi bi bundle ismimiz. Bundle.main.path bunu diyerek gidilecek patikayı oluşturduk. forResource bizim resource ismimiz yani users.json gibi. ofType a da ne dosyası olduğunu yazıyoruz
            fatalError("Resource not found")
        }
        
        let data = try Data(contentsOf: URL(filePath: path)) // contentsOf bu url yi soruyor. bunun içine oluşturduğumuz path i verdikten sonra data yı okumuş oluyoruz, aynı internetten çekmek gibi
        
        return try JSONDecoder().decode([User].self, from: data)
        
    }
    
}
