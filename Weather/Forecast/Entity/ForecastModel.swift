//
//  ForecastModel.swift
//  Weather
//
//  Created by Ефремов Владимир on 15.09.2018.
//  Copyright © 2018 OrangeSoda. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

/// Модель прогноза
class ForecastModel: Object {
    
    @objc dynamic var forecastId = UUID().uuidString /// primary key
    @objc dynamic var city: CityModel? /// Модель города
    @objc dynamic var weather: WeatherModel?
    var weatherDetail = List<WeatherModel>() /// Список погоды
    
    override static func primaryKey() -> String? {
        return "forecastId"
    }
    
    convenience init(city: CityModel, weather: WeatherModel?, weatherDetailList: [WeatherModel]) {
        self.init()
        self.city = city
        self.weather = weather
        for weather in weatherDetailList {
            self.weatherDetail.append(weather)
        }
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
