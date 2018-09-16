//
//  CitiesInteractor.swift
//  Weather
//
//  Created by Ефремов Владимир on 15.09.2018.
//  Copyright © 2018 OrangeSoda. All rights reserved.
//

import Foundation

final class CitiesInteractor: PresenterToCitiesInteractorProtocol {
    
    var presenter: InteractorToCitiesPresenterProtocol?

    func addForecastFor(city: CityModel) {
        CacheManager.addForecastFor(city: city)
        presenter?.forecastAdded()
    }
    
    func fetchCities(by name: String) {
        presenter?.citiesFetchedSuccess(cities: CacheManager.searchCity(by: name))
    }
}
