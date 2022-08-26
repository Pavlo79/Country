//
//  MovieTableViewCell.swift
//  Rest API
//
//  Created by Niso on 4/29/20.
//  Copyright © 2020 Niso. All rights reserved.
//

import UIKit

protocol CountryCellDelegate: class {
  func onItemSelected(_ country: Country)
}




class CountryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var capital: UILabel!
    @IBOutlet weak var description_small: UILabel!
    @IBAction func goCountry_info(_ sender: Any) {
        delegate?.onItemSelected(country!)
    }
    weak var delegate: CountryCellDelegate?
    let apiService = ApiService()
    var imageUrl : String?
    var country : Country?
    
    override func prepareForReuse(){
        super.prepareForReuse()
        
        flag.image = UIImage(named: "noImageAvailable")
    }
    
    func setCellWithValuesOf(_ country:Country){
        updateUI(name: country.name, capital: country.capital, description_small: country.description_small, imageUrl: country.country_info.flag)
        self.country = country
    }
    
    private func updateUI(name: String?, capital: String?, description_small: String?, imageUrl: String){
        print(name)
        self.imageUrl = imageUrl
    
        self.name.text = name
        self.capital.text = capital
        self.description_small.text = description_small
        self.apiService.downloadImage(urlString: imageUrl, completion: { [weak self] result in
            guard let self = self else{
                return
            }
            print(self.imageUrl)
            print(imageUrl)
            guard self.imageUrl == imageUrl else{
                return
            }
            switch result{
            case .success(let image):
                self.flag.image = image
            case .failure(let error):
                print(error)
            }
        })
        
    }
    
//    private func getImageDataFrom(url: URL) {
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                print("DataTask error: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let data = data else {
//                // Handle Empty Data
//                print("Empty Data")
//                return
//            }
//            
//            DispatchQueue.main.async {
//                if let image = UIImage(data: data) {
//                    
//                }
//            }
//        }.resume()
//    }
    
    
}


extension CountryTableViewCell: CountryCellDelegate {
    func onItemSelected(_ country: Country) {
        delegate?.onItemSelected(country)
    }
}

