//
//  CitiesRouter.swift
//  Weather
//
//  Created by Ефремов Владимир on 15.09.2018.
//  Copyright © 2018 OrangeSoda. All rights reserved.
//
import UIKit

final class CitiesRouter: PresenterToCitiesRouterProtocol {
    
    static func assembleModule() -> UIViewController {
        
        let vc = mainstoryboard.instantiateViewController(withIdentifier: "CitiesViewController") as! CitiesViewController
        let presenter: ViewToCitiesPresenterProtocol & InteractorToCitiesPresenterProtocol = CitiesPresenter()
        let interactor: PresenterToCitiesInteractorProtocol = CitiesInteractor()
        let router:PresenterToCitiesRouterProtocol = CitiesRouter()
        
        vc.presentor = presenter
        presenter.view = vc
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return vc
        
    }
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
}
