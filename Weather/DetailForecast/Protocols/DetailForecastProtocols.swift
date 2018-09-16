//
//  DetailForecastProtocols.swift
//  Weather
//
//  Created by Ефремов Владимир on 16.09.2018.
//  Copyright © 2018 OrangeSoda. All rights reserved.
//

import UIKit

protocol ViewToDetailForecastPresenterProtocol: class {
    var cityId: Int {get set}
    var view: PresenterToDetailForecastViewProtocol? {get set}
    var interactor: PresenterToDetailForecastInteractorProtocol? {get set}
    var router: PresenterToDetailForecastRouterProtocol? {get set}
    func startFetchingWeather()
}

protocol PresenterToDetailForecastViewProtocol: class {
    func showWeather(items: [ForecastItem])
}

protocol PresenterToDetailForecastInteractorProtocol: class {
    var presenter:InteractorToDetailForecastPresenterProtocol? {get set}
    func fetchWeather(by cityId: Int)
}

protocol InteractorToDetailForecastPresenterProtocol: class {
    func weatherFetchedSuccess(weatherList: [WeatherModel])
}

protocol PresenterToDetailForecastRouterProtocol: class {
    static func assembleModule(cityId: Int) -> UIViewController
}
