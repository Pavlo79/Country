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
    
    func getCountryData(urlString: String,completion: @escaping (Result<CountriesData, Error>) -> Void) {
                
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

