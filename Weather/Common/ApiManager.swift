//
//  ApiManager.swift
//  Weather
//
//  Created by Ефремов Владимир on 16.09.2018.
//  Copyright © 2018 OrangeSoda. All rights reserved.
//

import Foundation
import Alamofire

final class ApiManager {
    
    private static let apiUrl = "http://api.openweathermap.org/data/2.5/"
    private static let appid = "991acbca968fab19fbc91d4efef98406"
    
    static func getDetailForecast(by cityId: Int, complection: @escaping ([WeatherModel]) -> ()) {
        Alamofire.request(apiUrl + "forecast", method: .get, parameters: [ "id" : "\(cityId)", "appid" : appid, "units" : "metric"] ).responseJSON { (response) in
            
            guard response.response?.statusCode == 200, let json = response.result.value as? NSDictionary, let arrayResponse = json["list"] else { return }
            do {
                let jsonDecoder = JSONDecoder()
                let weatherList = try jsonDecoder.decodeJSON([WeatherModel].self, from: arrayResponse as Any)
                complection(weatherList)
            } catch {
                print("failed to convert data")
            }
        }
    }

    static func getWeatherInCities(by ids: [Int], complection: @escaping ([WeatherModel]) -> ()) {
        
        let stringIds: String = ids.map{String($0)}.joined(separator: ",")

        Alamofire.request(apiUrl + "group", method: .get, parameters: [ "id" : stringIds, "appid" : appid, "units" : "metric"] ).responseJSON { (response) in
            
            guard response.response?.statusCode == 200, let json = response.result.value as? NSDictionary, let arrayResponse = json["list"] else { return }
            do {
                let jsonDecoder = JSONDecoder()
                let weatherList = try jsonDecoder.decodeJSON([WeatherModel].self, from: arrayResponse as Any)
                complection(weatherList)
            } catch {
                print("failed to convert data")
            }
        }
    }
    
    static func loadImage(by name: String, complection: @escaping (UIImage) -> ()) {
        Alamofire.request("https://openweathermap.org/img/w/" + "\(name)" + ".png").responseData { (response) in
            if response.error == nil {
                if let data = response.data {
                    complection(UIImage(data: data) ?? UIImage())
                }
            }
        }
    }
    
}

extension JSONDecoder {

    func decodeJSON<T>(_ type: T.Type = T.self, from json: Any) throws -> T where T: Decodable {
        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        return try decode(T.self, from: data)
    }
}
