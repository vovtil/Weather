//
//  CitiesProtocols.swift
//  Weather
//
//  Created by Ефремов Владимир on 15.09.2018.
//  Copyright © 2018 OrangeSoda. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToCitiesPresenterProtocol: class {
    var view: PresenterToCitiesViewProtocol? {get set}
    var interactor: PresenterToCitiesInteractorProtocol? {get set}
    var router: PresenterToCitiesRouterProtocol? {get set}
    func startFetchingCities(by name: String)
    func addForecast(by index: Int)
}

protocol PresenterToCitiesViewProtocol: class {
    func showCities(items: [CityItem])
    func forecastAdded()
}

protocol PresenterToCitiesInteractorProtocol: class {
    var presenter:InteractorToCitiesPresenterProtocol? {get set}
    func fetchCities(by name: String)
    func addForecastFor(city: CityModel)
}

protocol InteractorToCitiesPresenterProtocol: class {
    func citiesFetchedSuccess(cities: [CityModel])
    func forecastAdded()
}

protocol PresenterToCitiesRouterProtocol: class {
    static func assembleModule() -> UIViewController
}
