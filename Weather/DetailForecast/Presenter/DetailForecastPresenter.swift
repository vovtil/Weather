//
//  DetailForecastPresenter.swift
//  Weather
//
//  Created by Ефремов Владимир on 16.09.2018.
//  Copyright © 2018 OrangeSoda. All rights reserved.
//

import Foundation

final class DetailForecastPresenter: ViewToDetailForecastPresenterProtocol {
    
    var view: PresenterToDetailForecastViewProtocol?
    var interactor: PresenterToDetailForecastInteractorProtocol?
    var router: PresenterToDetailForecastRouterProtocol?
    var cityId: Int = 0
    
    func startFetchingWeather() {
        interactor?.fetchWeather(by: cityId)
    }
}

extension DetailForecastPresenter: InteractorToDetailForecastPresenterProtocol{
    
    func weatherFetchedSuccess(weatherList: [WeatherModel]) {

        let items = weatherList.map { (weather) -> ForecastItem in
            let item = ForecastItem(weather: weather)
            return item
        }
        view?.showWeather(items: items)
    }
}

extension ForecastItem {
    init(weather: WeatherModel) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM HH:mm"
        self.init(
            title:"\(Int(weather.tempMin))°C" + " - " + "\(Int(weather.tempMax))°C",
            dateTitle: "Date: " + formatter.string(from: (weather.date)),
            subTitle: "humidity" + " - " + "\(weather.humidity)" + " " + "pressure" + " - " + "\(weather.pressure)",
            description: weather.descriptionWeather,
            iconName: weather.icon)
    }
}
