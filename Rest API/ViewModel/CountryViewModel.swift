//
//  MovieViewModel.swift
//  Rest API
//
//  Created by Niso on 4/29/20.
//  Copyright © 2020 Niso. All rights reserved.
//

import Foundation

class CountryViewModel {
    private var apiService = ApiService()
    //private var country = apiService.country
    private var url: String = "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json"

    
    func fetchCountriesData(completion: @escaping () -> ()) {
        apiService.getCountryData(urlString: url) { [weak self] (result) in
            switch result {
            case .success(let countries):
                self?.apiService.country = countries.countries
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
        //apiService.uploadNextPage()
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if apiService.country.count != 0 {
            return apiService.country.count
        }
        return 0
    }
    func itemAt (indexPath: IndexPath) -> Country {
        return apiService.country[indexPath.row]
    }
}
