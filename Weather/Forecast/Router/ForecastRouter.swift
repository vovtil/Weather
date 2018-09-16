//
//  ForecastRouter.swift
//  Weather
//
//  Created by Ефремов Владимир on 16.09.2018.
//  Copyright © 2018 OrangeSoda. All rights reserved.
//

import UIKit

final class ForecastRouter: PresenterToForecastRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "ForecastViewController") as! ForecastViewController
        let presenter: ViewToForecastPresenterProtocol & InteractorToForecastPresenterProtocol = ForecastPresenter()
        let interactor: PresenterToForecastInteractorProtocol = ForecastInteractor()
        let router = ForecastRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.viewController = view
        
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func routeToCities() {
        let vc = CitiesRouter.assembleModule()
        self.viewController?.present(vc, animated: true, completion: nil)
    }
    
    func routeToDetailForecast(by cityId: Int) {
        let vc = DetailForecastRouter.assembleModule(cityId: cityId)
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
