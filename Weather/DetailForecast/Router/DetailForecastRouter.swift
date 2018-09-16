//
//  DetailForecastRouter.swift
//  Weather
//
//  Created by Ефремов Владимир on 16.09.2018.
//  Copyright © 2018 OrangeSoda. All rights reserved.
//

import UIKit

final class DetailForecastRouter: PresenterToDetailForecastRouterProtocol {
    
    static func assembleModule(cityId: Int) -> UIViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "DetailForecastViewController") as! DetailForecastViewController
        let presenter: ViewToDetailForecastPresenterProtocol & InteractorToDetailForecastPresenterProtocol = DetailForecastPresenter()
        let interactor: PresenterToDetailForecastInteractorProtocol = DetailForecastInteractor()
        let router = DetailForecastRouter()
        presenter.cityId = cityId
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
}
