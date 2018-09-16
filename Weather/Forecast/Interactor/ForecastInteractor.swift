//
//  ForecastInteractor.swift
//  Weather
//
//  Created by Ефремов Владимир on 16.09.2018.
//  Copyright © 2018 OrangeSoda. All rights reserved.
//

import Foundation

final class ForecastInteractor: PresenterToForecastInteractorProtocol {
    
    var presenter: InteractorToForecastPresenterProtocol?
    private lazy var timer = Timer.scheduledTimer(timeInterval: 30.0,
                                                            target: self,
                                                            selector: #selector(self.fetchForecast),
                                                            userInfo: nil,
                                                            repeats: true)
    
    init() {
        timer.fire()
    }
    
    @objc func fetchForecast() {
        presenter?.forecastFetchedSuccess(forecasts: CacheManager.getAllForecast())
    }
    
    func updateWeather(citiesId: [Int]) {
        ApiManager.getWeatherInCities(by: citiesId) { [weak self] weatherList in
            CacheManager.updateWeather(by: weatherList)
            self?.presenter?.forecastWeatherSuccess()
        }
    }
    
}
