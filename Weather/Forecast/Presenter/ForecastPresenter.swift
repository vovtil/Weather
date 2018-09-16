//
//  ForecastPresentor.swift
//  Weather
//
//  Created by Ефремов Владимир on 16.09.2018.
//  Copyright © 2018 OrangeSoda. All rights reserved.
//

import Foundation
import UIKit

final class ForecastPresenter: ViewToForecastPresenterProtocol {    

    var view: PresenterToForecastViewProtocol?
    
    var interactor: PresenterToForecastInteractorProtocol?
    
    var router: PresenterToForecastRouterProtocol?
    
    fileprivate var forecastList: [ForecastModel] = []
    
    func startFetchingForecast() {
        interactor?.fetchForecast()
    }
    
    func startUpdateWeather() {
        var citiesId: [Int] = []
        for forecast in forecastList {
            if let city = forecast.city {
                citiesId.append(city.cityId)
            }
        }
        interactor?.updateWeather(citiesId: citiesId)
    }
    
    func routeToCities() {
        router?.routeToCities()
    }
    
    func routeToDetailForecast(by index: Int) {
        guard index < forecastList.count, let city = forecastList[index].city else { return }
        router?.routeToDetailForecast(by: city.cityId)
    }
}

extension ForecastPresenter: InteractorToForecastPresenterProtocol{
    
    func forecastWeatherSuccess() {
        view?.weatherUpdate()
    }
    
    func forecastFetchedSuccess(forecasts: [ForecastModel]) {
        forecastList = forecasts
        
        let items = forecasts.map { (forecast) -> ForecastItem in
            let item = ForecastItem(forecast: forecast)
            return item
        }
      
        view?.showForecast(items: items)
    }
}

extension ForecastItem {
    init(forecast: ForecastModel) {
        var title = ""
        if let name = forecast.city?.name, let country = forecast.city?.country {
            title = name + " " + country
        }
        
        var subtiltle = ""
        if let min = forecast.weather?.tempMin, let max = forecast.weather?.tempMax {
            subtiltle = "\(Int(min))°C" + " - " + "\(Int(max))°C"
        }
        
        self.init(title: title,
                  dateTitle: "",
                  subTitle: subtiltle,
                  description: forecast.weather?.descriptionWeather ?? "",
                  iconName: forecast.weather?.icon ?? "")
    }
}
