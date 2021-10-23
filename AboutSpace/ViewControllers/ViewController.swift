//
//  ViewController.swift
//  AboutSpace
//
//  Created by iMac on 14.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    //поле для картинки
    @IBOutlet var imageView: UIImageView!
    //индикатор загрузки:
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //запускаем анимацию у ромашки
        activityIndicator.startAnimating()
        //скрываем ромашку, после того, как мы его остановим
        activityIndicator.hidesWhenStopped = true
        //метод загрузки картинки
        fetchImage()
    }
    
    //сетевой запрос
    private func fetchImage() {
        NetworkManager.shared.fetchImage(from: Link.imageURL.rawValue) { result in
            switch result {
            case .success(let imageData):
                self.imageView.image = UIImage(data: imageData)
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

