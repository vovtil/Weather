//
//  ForecastProtocols.swift
//  Weather
//
//  Created by Ефремов Владимир on 16.09.2018.
//  Copyright © 2018 OrangeSoda. All rights reserved.
//

import UIKit

protocol ViewToForecastPresenterProtocol: class {
    var view: PresenterToForecastViewProtocol? {get set}
    var interactor: PresenterToForecastInteractorProtocol? {get set}
    var router: PresenterToForecastRouterProtocol? {get set}
    func startFetchingForecast()
    func startUpdateWeather()
    func routeToCities()
    func routeToDetailForecast(by index: Int)
}

protocol PresenterToForecastViewProtocol: class {
    func showForecast(items: [ForecastItem])
    func weatherUpdate()
}

protocol PresenterToForecastInteractorProtocol: class {
    var presenter:InteractorToForecastPresenterProtocol? {get set}
    func fetchForecast()
    func updateWeather(citiesId: [Int])
}

protocol InteractorToForecastPresenterProtocol: class {
    func forecastFetchedSuccess(forecasts: [ForecastModel])
    func forecastWeatherSuccess()
}

protocol PresenterToForecastRouterProtocol: class {
    static func assembleModule() -> UIViewController
    func routeToCities()
    func routeToDetailForecast(by cityId: Int)
}
