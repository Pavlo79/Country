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
    private var country = [Country]()
    private var country1 = [Country]()
    private var country2 = [Country]()
    private var next: String = "https://rawgit.com/NikitaAsabin/b37bf67c8668d54a517e02fdf0e0d435/raw/2021870812a13c6dbae1f8a0e9845661396c1e8d/page2.json"
    let CountryUrl = "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json"
    
    func fetchCountriesData(completion: @escaping () -> ()) {
        
        apiService.getCountryData(urlString: CountryUrl) { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.country = listOf.countries
                self?.next = listOf.next
                completion()
            case .failure(let error):

                print("Error processing json data: \(error)")
            }
        }
        apiService.getCountryData(urlString: next) { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.country2 = listOf.countries
                completion()
            case .failure(let error):

                print("Error processing json data: \(error)")
            }
            //country = country1 + country2
        }
    }
    func ConcatenatingStruct() {
        country = country1 + country2
    }
    func numberOfRowsInSection(section: Int) -> Int {
        if country.count != 0 {
            return country.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Country {
        return country[indexPath.row]
    }

}
