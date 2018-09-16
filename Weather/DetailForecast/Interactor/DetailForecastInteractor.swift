//
//  DetailForecastInteractor.swift
//  Weather
//
//  Created by Ефремов Владимир on 16.09.2018.
//  Copyright © 2018 OrangeSoda. All rights reserved.
//

import Foundation

final class DetailForecastInteractor: PresenterToDetailForecastInteractorProtocol {
    
    var presenter: InteractorToDetailForecastPresenterProtocol?
    
    func fetchWeather(by cityId: Int) {
        if let weatherList = CacheManager.getForecastCity(by: cityId)?.weatherDetail {
            self.presenter?.weatherFetchedSuccess(weatherList: Array(weatherList))
        }
        ApiManager.getDetailForecast(by: cityId) { [weak self] weatherList in
            CacheManager.updateDetailWeather(by: cityId, weather: weatherList)
            self?.presenter?.weatherFetchedSuccess(weatherList: weatherList)
        }
    }
}
