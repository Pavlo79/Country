//
//  ApiService.swift
//  Rest API
//
//  Created by Niso on 4/29/20.
//  Copyright © 2020 Niso. All rights reserved.
//

import Foundation
import UIKit

class ApiService {
    var country = [Country]()
    var country2 = [Country]()
    var url = "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json"
    var nextUrl = "https://rawgit.com/NikitaAsabin/b37bf67c8668d54a517e02fdf0e0d435/raw/2021870812a13c6dbae1f8a0e9845661396c1e8d/page1f.json"
    
    func uploadNextPage() {
        print("url\(nextUrl)")
        if nextUrl != "" {
            getCountryData(urlString: nextUrl) { [weak self] (result) in
                switch result {
                case .success(let countries):
                    self?.country += countries.countries
                case .failure(let error):
                    print("Error processing json data: \(error)")
                }
            }
        }
        
        print("sucsees")
    }
    
    func getCountryData(urlString: String,completion: @escaping (Result<CountriesData, Error>) -> Void) {
        
        //let CountryURL = "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json"
        
        guard let url = URL(string: urlString) else {return}
        
        // Create URL Session - work on the background
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(CountriesData.self, from: data)
                
                // Back to the main thread
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                    self.nextUrl = jsonData.next ?? ""
                    
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask.resume()
    }

    func downloadImage(urlString: String,completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {return}
        
        // Create URL Session - work on the background
        let dataTask = URLSession.shared.dataTask(with: url) { [urlString](data, response, error) in
            //https://cdn.nieuws.nl/media/sites/417/2017/03/27111018/engels-715x408.png
            print(urlString)
            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                // TODO: Create custom error object and call completion callback
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            guard let image = UIImage(data: data) else {
                print("Empty Data")
                return
            }
            // Back to the main thread
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }
        dataTask.resume()
    }
}

