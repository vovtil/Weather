//
//  Weather.swift
//  Weather
//
//  Created by Ефремов Владимир on 15.09.2018.
//  Copyright © 2018 OrangeSoda. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

struct WeatherList {
    let description: String
    let icon: String
}

/// Дополнительная информация по погоде
extension WeatherList: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case description /// Описание
        case icon /// Иконка
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        description = try container.decode(String.self, forKey: .description)
        icon = try container.decode(String.self, forKey: .icon)
    }
}

/// Основная информация по погоде
struct WeatherMain {
    let temp: Double
    let pressure: Double
    let humidity: Double
    let tempMin: Double
    let tempMax: Double
}

extension WeatherMain: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case temp /// Средняя температура
        case pressure /// Давление
        case humidity /// Влажность
        case temp_min /// Минимальная температура
        case temp_max /// Максимальная температура
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temp = try container.decode(Double.self, forKey: .temp)
        pressure = try container.decode(Double.self, forKey: .pressure)
        humidity = try container.decode(Double.self, forKey: .humidity)
        tempMin = try container.decode(Double.self, forKey: .temp_min)
        tempMax = try container.decode(Double.self, forKey: .temp_max)
    }
}

///Модель погоды
class WeatherModel: Object, Decodable {
   
    @objc dynamic var weatherId = UUID().uuidString /// primary key
    @objc dynamic var cityId: Int = 0 /// Ид города
    @objc dynamic var name: String = "" /// Имя города
    @objc dynamic var temp: Double = 0 /// Средняя температура
    @objc dynamic var pressure: Double = 0 /// Давление
    @objc dynamic var humidity: Double = 0 /// Влажность
    @objc dynamic var tempMin: Double = 0 /// Минимальная температура
    @objc dynamic var tempMax: Double = 0 /// Максимальная температура
    @objc dynamic var descriptionWeather: String = ""  /// Описание
    @objc dynamic var icon: String = ""  /// Иконка
    @objc dynamic var date: Date = Date() /// Дата
    
    override static func primaryKey() -> String? {
        return "weatherId"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case main
        case weather
        case date = "dt"
    }
    
    convenience init(cityId: Int,
                     name: String,
                     date: Date,
                     temp: Double,
                     pressure: Double,
                     humidity: Double,
                     tempMin: Double,
                     tempMax: Double,
                     weatherList: [WeatherList]) {
        self.init()
        self.cityId = cityId
        self.name = name
        self.date = date
        self.temp = temp
        self.pressure = pressure
        self.humidity = humidity
        self.tempMin = tempMin
        self.tempMax = tempMax
        if let weather = weatherList.first {
            self.icon = weather.icon
            self.descriptionWeather = weather.description
        }
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let cityId = try? container.decode(Int.self, forKey: .id)
        let name = try? container.decode(String.self, forKey: .name)
        let dateIntreval = try container.decode(Double.self, forKey: .date)
        let main = try container.decode(WeatherMain.self, forKey: .main)
        let weatherList = try container.decode([WeatherList].self, forKey: .weather)
        let date = Date(timeIntervalSince1970: dateIntreval)
        self.init(cityId: cityId ?? 0,
                  name: name ?? "",
                  date: date,
                  temp: main.temp,
                  pressure: main.pressure,
                  humidity: main.humidity,
                  tempMin: main.tempMin,
                  tempMax: main.tempMax,
                  weatherList: weatherList)
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}
