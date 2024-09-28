//
//  ContentView.swift
//  HeroWidget
//
//  Created by Dilara Akdeniz on 26.09.2024.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    
    //UserDefaults kullanılarak basit bir kaydetme işlemi yapıldı
    //"hero" bu kısım için key olmuş olur
    @AppStorage("hero", store: UserDefaults(suiteName: "group.com.dilarakdeniz.HeroWidget"))
    var heroData : Data = Data()
    
    let superHeroArray = [batman, hulk, spiderman, ironman]
    
    var body: some View {
        VStack {
            ForEach(superHeroArray) { hero in
                HeroView(hero: hero).onTapGesture {
                    saveToDefaults(hero: hero)
                }
            }
        }
    }
    
    //Bu fonksiyonda UserDefaultsa kaydedebilmek için verimizi encode ettik ve yukarıda tanımladığımız heroData içerisine atmış olduk.
    func saveToDefaults(hero: SuperHero) {
        if let heroData = try? JSONEncoder().encode(hero) {
            self.heroData = heroData
            print(hero.name) //Veri encode oluyor mu loglarda görmek için yaptık. (Test amaçlı)
            
            WidgetCenter.shared.reloadTimelines(ofKind: "WidgetHero") //Bu kısım appde değişiklik yapınca widgeta ulaşmak ve değişikliklerin widgeta iletilmesi ve değişikliğin yapılmasının sağlanmasıdır.te
        }
    }
}

#Preview {
    ContentView()
}
