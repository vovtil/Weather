//
//  DetailForecastViewController.swift
//  Weather
//
//  Created by Ефремов Владимир on 16.09.2018.
//  Copyright © 2018 OrangeSoda. All rights reserved.
//

import UIKit

class DetailForecastViewController: UIViewController {

    var presentor:ViewToDetailForecastPresenterProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var weatherItems: [ForecastItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail Forecast"
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presentor?.startFetchingWeather()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DetailForecastViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "DetailForecastCell") as? DetailForecastCell {
            let item = weatherItems[indexPath.row]
            cell.configurate(item: item)
            return cell
        }
        return UITableViewCell()
    }
}

extension DetailForecastViewController: PresenterToDetailForecastViewProtocol {
    
    func showWeather(items: [ForecastItem]) {
        self.weatherItems = items
        tableView.reloadData()
    }

}
