//
//  WeatherViewController.swift
//  TestApp
//
//  Created by Mikhail Serov on 14.03.2020.
//  Copyright © 2020 TestApp. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loaderView: UIView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var errorLabel: UILabel!
    
    private let viewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.searchTextField.textColor = .white
        searchBar.setImage(#imageLiteral(resourceName: "icSearchWhite"), for: .search, state: .normal)
        tableView.register(UINib(nibName: WeatherCell.className, bundle: .none), forCellReuseIdentifier: WeatherCell.className)
        tableView.tableFooterView = UIView()
        loaderView.alpha = 0
        loadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func loadData(query: String? = nil) {
        loaderView.fadeOut()
        viewModel.getWeather(query: query) { [weak self] error in
            self?.errorLabel.text = error?.localizedDescription
            self?.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            self?.loaderView.fadeIn()
        }
    }
}

extension WeatherViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        loadData(query: searchBar.text)
    }

}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weatherItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.className, for: indexPath)
        let item = viewModel.weatherItems[indexPath.row]
        if let cell = cell as? WeatherCell {
            cell.setup(with: item)
        }
        return cell
    }

}
