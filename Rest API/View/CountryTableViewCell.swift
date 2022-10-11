//
//  MovieTableViewCell.swift
//  Rest API
//
//  Created by Niso on 4/29/20.
//  Copyright © 2020 Niso. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var capital: UILabel!
    @IBOutlet weak var descriptionSmall: UILabel!
    @IBAction func bb(_ sender: Any) {
        apiService.uploadNextPage()
    }
    
    let apiService = ApiService()
    var imageUrl: String?
    var country: Country?
    
    override func prepareForReuse(){
        super.prepareForReuse()
        flag.image = UIImage(named: "noImageAvailable")
    }
    
    func configure(_ country: Country){
        updateUI(name: country.name, capital: country.capital, descriptionSmall: country.descriptionSmall, imageUrl: country.country_info.flag)
        self.country = country
    }
    
    private func updateUI(name: String?, capital: String?, descriptionSmall: String?, imageUrl: String){
        self.imageUrl = imageUrl
        self.name.text = name
        self.capital.text = capital
        self.descriptionSmall.text = descriptionSmall
        self.apiService.downloadImage(urlString: imageUrl, completion: { [weak self] result in
            guard let self = self else{
                return
            }
            print(imageUrl)
         
            switch result{
            case .success(let image):
                self.flag.image = image
            case .failure(let error):
                print(error)
            }
        })
    }
}
