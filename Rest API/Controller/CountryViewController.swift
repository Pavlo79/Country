//
//  ViewController.swift
//  Rest API
//
//  Created by Niso on 4/29/20.
//  Copyright © 2020 Niso. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = CountryViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadCountriesData()
    }
    
    private func loadCountriesData() {
        viewModel.fetchCountriesData { [weak self] in
            
            self?.tableView.dataSource = self
            self?.tableView.delegate = self
            self?.tableView.reloadData()
        }
    }
}

// MARK: - TableView
extension CountryViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CountryTableViewCell
        let country = viewModel.itemAt(indexPath: indexPath)
        
        cell.setCellWithValuesOf(country)
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Country_info") as? Country_infoViewController
        let country = viewModel.itemAt(indexPath: indexPath)
        vc?.name = country.name
        vc?.capital = country.capital
        vc?.population = country.population
        vc?.continent = country.continent
        vc?.about = country.description
        vc?.imagesURL = country.country_info.images
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
