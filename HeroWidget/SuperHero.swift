//
//  SuperHero.swift
//  HeroWidget
//
//  Created by Dilara Akdeniz on 26.09.2024.
//

import Foundation

//Codable olmasının sebebi JSON Encoding ile encode edip veriye çevireceğiz, JSON Decoding ile decode edip veriden tekrar hero formatına çevireceğiz.
//Identifiable olmasının sebebi ise SwiftUI'da ForEach içerisinde kolayca kullanılarak tableView'mış gibi gösterilebilmesidir.
struct SuperHero : Identifiable, Codable {
    
    let image : String //Resimler direkt assets içerisinde ve isimleri belli o yüzden String olarak tanımlandı.
    let name : String
    let realName : String
    
    var id: String {image} //Codable olduğu için id tanımladık.
    //{image} oluşturulan id kendi resmi ve ismiyle eşleşsin denildi.
    
    
}

let batman = SuperHero(image: "batman", name: "Batman", realName: "Bruce Wayne")
let hulk = SuperHero(image: "hulk", name: "Hulk", realName: "Bruce Banner")
let ironman = SuperHero(image: "ironman", name: "Ironman", realName: "Tony Stark")
let spiderman = SuperHero(image: "spiderman", name: "Spiderman", realName: "Tom Holland")
