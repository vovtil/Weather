//
//  ForecastViewController.swift
//  Weather
//
//  Created by Ефремов Владимир on 16.09.2018.
//  Copyright © 2018 OrangeSoda. All rights reserved.
//

import UIKit

final class ForecastViewController: UIViewController {
    var presentor:ViewToForecastPresenterProtocol?
    
    fileprivate var forecastItems: [ForecastItem] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Forecast"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add city",
                                                                   style: .plain,
                                                                   target: self,
                                                                   action: #selector(addCityAction))
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presentor?.startFetchingForecast()
        presentor?.startUpdateWeather()
    }
    
    @objc private func addCityAction() {
        presentor?.routeToCities()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "ForecastCell") as? ForecastCell {
            let item = self.forecastItems[indexPath.row]
            cell.configurate(item: item)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentor?.routeToDetailForecast(by: indexPath.row)
    }
}

extension ForecastViewController: PresenterToForecastViewProtocol {
    
    func weatherUpdate() {
        presentor?.startFetchingForecast()
    }
    
    func showForecast(items: [ForecastItem]) {
        forecastItems = items
        tableView.reloadData()
    }
}
