//
//  Country_infoViewController.swift
//  Rest API
//
//  Created by Seven on 31.07.2022.
//  Copyright © 2022 Niso. All rights reserved.
//

import UIKit

class Country_infoViewController: UIViewController {
    
    @IBOutlet weak var scrollImageView: UIScrollView!
    @IBOutlet weak var scrollTextView: UIScrollView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelCapital: UILabel!
    @IBOutlet weak var labelPopulation: UILabel!
    @IBOutlet weak var labelContinent: UILabel!
    @IBOutlet weak var labelAbout: UILabel!
   
    let pageControl = UIPageControl()
    var imagesURL : [String] = []
    
    private var viewModel = Country_infoViewModel()
    var name = ""
    var capital = ""
    var population = 0
    var continent = ""
    var about = ""
    
    let apiService = ApiService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateScrollImageView()
        configurateScrollTextView()
        
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: scrollImageView.bottomAnchor, constant: -30),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        pageControl.numberOfPages = imagesURL.count
        pageControl.addTarget(self, action: #selector(pageDidChange(sender:)), for: .valueChanged)
        scrollImageView.delegate = self
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.view.tintColor = UIColor.white
    }
   
    @objc func pageDidChange(sender: UIPageControl) {
        let ofsetX = UIScreen.main.bounds.width * CGFloat(pageControl.currentPage)
        scrollImageView.setContentOffset(CGPoint(x: ofsetX, y: 0), animated: true)
    }
}
//MARK: - UIScrollViewDelegate
extension Country_infoViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
    }
}
extension Country_infoViewController {
    func configurateScrollImageView() {
        view.addSubview(scrollImageView)
        scrollImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollImageView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
        scrollImageView.contentSize = CGSize(width: Int(UIScreen.main.bounds.width) * imagesURL.count, height: 250)
        scrollImageView.isPagingEnabled = true
        if imagesURL.isEmpty
        {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "noImageAvailable")
            scrollImageView.addSubview(imageView)
            imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250)
        } else {
            for i in 0 ..< imagesURL.count {
                addImage(imageUrl: imagesURL[i], position: CGFloat(i))
            }
        }
    }
    func addImage(imageUrl: String, position: CGFloat) {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noImageAvailable")
        apiService.downloadImage(urlString: imageUrl, completion: { [weak self] result in
            print("image url \(imageUrl)")
        
            switch result{
            case .success(let image):
                imageView.image = image
                
            case .failure(let error):
                print(error)
            }
        })
        
        scrollImageView.addSubview(imageView)
        let screenWight = UIScreen.main.bounds.width
        imageView.frame = CGRect(x: screenWight * position, y: 0, width: screenWight, height: 250)
    }
    func configurateScrollTextView() {
        labelName.text = name
        labelCapital.text = capital
        labelPopulation.text = spaces(population)
        labelContinent.text = continent
        labelAbout.text = about
    }
    
    func spaces(_ int: Int) -> String{
        var str = String(int)
        if str.count >= 6 {
            str.insert(" ", at: str.index(str.endIndex, offsetBy: -6))
            str.insert(" ", at: str.index(str.endIndex, offsetBy: -3))
        }
        return str
    }
}
