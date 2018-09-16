//
//  CitiesPresentor.swift
//  Weather
//
//  Created by Ефремов Владимир on 15.09.2018.
//  Copyright © 2018 OrangeSoda. All rights reserved.
//

import Foundation
import UIKit

final class CitiesPresenter: ViewToCitiesPresenterProtocol {

    var view: PresenterToCitiesViewProtocol?
    
    var interactor: PresenterToCitiesInteractorProtocol?
    
    var router: PresenterToCitiesRouterProtocol?
    
    fileprivate var cityList: [CityModel] = []
    
    func startFetchingCities(by name: String) {
        interactor?.fetchCities(by: name)
    }
    
    func addForecast(by index: Int) {
        if index < cityList.count {
            interactor?.addForecastFor(city: cityList[index])
        }
    }
}

extension CitiesPresenter: InteractorToCitiesPresenterProtocol{
    
    func forecastAdded() {
        view?.forecastAdded()
    }
    
    func citiesFetchedSuccess(cities: [CityModel]) {
        self.cityList = cities
        let items = cities.map { (city) -> CityItem in
            let item = CityItem(name: city.name, country: city.country)
            return item
        }
        view?.showCities(items: items)
    }
    
}
