//
//  WidgetHero.swift
//  WidgetHero
//
//  Created by Dilara Akdeniz on 28.09.2024.
//





//Bu kısımdan önce widget'tan önce widget'ta kullanılmak üzere oluşturulan tüm dosyalarda sağ taraflarında bulunan Target Membership kısmından Widget Extension da target olarka seçilmelidir. Aksi takdirde bu kısımda görünmezler.
//Aynı zamanda projede Widget kısmı targettan seçilerek App.Storage o kısma da eklenmelidir.
import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    
    @AppStorage("hero", store: UserDefaults(suiteName: "group.com.dilarakdeniz.HeroWidget"))
    var heroData : Data = Data()
    
    //Artık kullanıcının ana ekranında  bulunulacağından dolayı görünümün daha güzel oması gerekmektedir. Aşağıda bulunan fonksiyon ile eğer senin widget'ın internetten veri çekiyorsa ya da yoğun bir işlem yapılıyorsa, o widget yüklenene kadar kullanıcıya doğru düzgün bir şey göstermek içindir. Placeholder yüklenen kısım yerine default bir şey göstermek için kullanılıyor.
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), hero: SuperHero(image: "batman", name: "Batman", realName: "Bruce Wayne")) //Default olarak batman gösterdik.
    }

    //Zaman içerisinde widget'lar değiştirilebilir. Örneğin sabah 9-12 arası farklı akşam farklı bir şey görünsün gibi olabilir. Snapshot ve timeline fonksiyonları bunun için oluşturulmuştur. (Bizim şu anki widget'ımızda bu yok çünkü biz kullanıcı hangi superHero'yu seçerse onu göstereceğiz.
    //Snapshot anlık olarak veritabanında bulunan şeyi göstermek için kullanılır.
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        //SimpleEntry(date: Date(), configuration: configuration, hero: <#SuperHero#>)
        
        if let hero = try? JSONDecoder().decode(SuperHero.self, from: heroData) {
            return SimpleEntry(date: Date(), configuration: configuration, hero: hero)
        } else{
            return SimpleEntry(date: Date(), configuration: configuration, hero: SuperHero(image: "batman", name: "Batman", realName: "Bruce Wayne"))
        }
        
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        
        if let hero = try? JSONDecoder().decode(SuperHero.self, from: heroData) {
            let entry = SimpleEntry(date: Date(), configuration: configuration, hero: hero)
            let timeline = Timeline(entries: [entry], policy: .never)
            return timeline
        } else{
            let entry = SimpleEntry(date: Date(), configuration: configuration, hero: SuperHero(image: "batman", name: "Batman", realName: "Bruce Wayne"))
            let timeline = Timeline(entries: [entry], policy: .never)
            return timeline
        }
        
        /*
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, hero: <#SuperHero#>)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .never) //Zamana göre değişim yapmayacağımız için policy kısmını never yaptık
         */
    }
}
//Entry bizim göstermek istediğimiz veridir. Örneğin bizim için bu superHero
struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let hero: SuperHero
}

//Tam olarak ön yüzde gösterilecek kısım
struct WidgetHeroEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            CircularImageView(image: Image(entry.hero.image))
            Text(entry.hero.name)
                    .font(.headline)
            Text(entry.hero.realName)
                    .font(.subheadline)
        }
    }
}

struct WidgetHero: Widget {
    let kind: String = "WidgetHero" //Hangi tipten bir widget. Birden fazla widget olursa diye var

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WidgetHeroEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}
/*
extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}
 */

#Preview(as: .systemSmall) {
    WidgetHero()
} timeline: {
    SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), hero: SuperHero(image: "batman", name: "Batman", realName: "Bruce Wayne"))
}
