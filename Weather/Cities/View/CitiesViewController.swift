//
//  ViewController.swift
//  Weather
//
//  Created by Ефремов Владимир on 15.09.2018.
//  Copyright © 2018 OrangeSoda. All rights reserved.
//

import UIKit

final class CitiesViewController: UIViewController {
   
    var presentor:ViewToCitiesPresenterProtocol?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var cityItems: [CityItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search city"
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CityCell")
        if let cell = cell {
            let item = self.cityItems[indexPath.row]
            cell.textLabel?.text = item.name + " " + item.country
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presentor?.addForecast(by: indexPath.row)
        self.dismiss(animated: true, completion: nil)
    }
}

extension CitiesViewController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 2 {
            presentor?.startFetchingCities(by: searchText)
        }
    }
    
}

extension CitiesViewController: PresenterToCitiesViewProtocol {
    
    func forecastAdded() {
        // TODO
    }
    
    func showCities(items: [CityItem]) {
        self.cityItems = items
        self.tableView.reloadData()
    }
}
