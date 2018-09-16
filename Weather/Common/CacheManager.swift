//
//  CasheManager.swift
//  Weather
//
//  Created by Ефремов Владимир on 16.09.2018.
//  Copyright © 2018 OrangeSoda. All rights reserved.
//

import Foundation
import RealmSwift

final class CacheManager {
    
    private static let realm: Realm = {
        //Realm(fileURL: Bundle.main.url(forResource: "weather", withExtension: "realm")!)
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return try! Realm()}
        let documentDirectoryFileUrl = documentsDirectory.appendingPathComponent("weather.realm")
        if !FileManager.default.fileExists(atPath: documentDirectoryFileUrl.path) {
            do {
                try FileManager.default.copyItem(at: Bundle.main.url(forResource: "weather", withExtension: "realm")!, to: documentDirectoryFileUrl)
            } catch {
                print("Could not copy file: \(error)")
            }
        }

        let realm = try! Realm(fileURL: documentDirectoryFileUrl)
        return realm
    }()
    
    /// Поиск города по имени
    static func searchCity(by name: String) -> [CityModel] {
       let cities = realm.objects(CityModel.self).filter("searchName BEGINSWITH '\(name.lowercased())'")
        return Array(cities)
    }
    
    static func searchCity(by cityId: Int) -> CityModel? {
        let city = realm.objects(CityModel.self).filter("cityId == '\(cityId)'")
        return city.first
    }
    
    /// Добавляем прогноз для города
    static func addForecastFor(city: CityModel) {
        let forecast = ForecastModel(city: city, weather: nil, weatherDetailList: [])
        try! realm.write {
            realm.add(forecast, update: true)
        }
    }

    /// Обновляем погоду в прогнозе
    static func updateWeather(by weatherList: [WeatherModel]) {
        for weather in weatherList {
            if let forecast = CacheManager.getForecastCity(by: weather.cityId) {
                try! realm.write {
                    if let weather = forecast.weather {
                        realm.delete(weather)
                    }
                    forecast.weather = weather
                    realm.add(forecast, update: true)
                }
            }
        }
    }
    
    /// Обновляем погоду в прогнозе
    static func updateDetailWeather(by cityId: Int ,weather: [WeatherModel]) {
        if let forecast = CacheManager.getForecastCity(by: cityId) {
            try! realm.write {
                realm.delete(forecast.weatherDetail)
                forecast.weatherDetail.append(objectsIn: weather)
                realm.add(forecast, update: true)
            }
        }
    }
    
    /// Получить все прогнозы
    static func getAllForecast() -> [ForecastModel] {
        let forecasts = realm.objects(ForecastModel.self)
        return Array(forecasts)
    }
    
    /// Получить прогноз для города
    static func getForecastCity(by cityId: Int) -> ForecastModel? {
        let forecasts = realm.objects(ForecastModel.self).filter("city.cityId == \(cityId)")
        return forecasts.first
    }
}
