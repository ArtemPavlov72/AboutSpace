//
//  RoverPhotoCell.swift
//  AboutSpace
//
//  Created by iMac on 20.10.2021.
//

import Foundation
import UIKit

//создаем свою ячейку для coursesViewController
class RoverPhotoCell: UITableViewCell {
    
    @IBOutlet var roverImage: UIImageView!
    @IBOutlet var roverNameLabel: UILabel!
    @IBOutlet var idPhoto: UILabel!
    @IBOutlet var dateOfPhoto: UILabel!
    
    //конфигурируем ячейку
    func configure(with roverPhoto: MarsRoverPhoto?) {
        //заполняем элементы интерфейса
        roverNameLabel.text = roverPhoto?.rover?.name
        idPhoto.text = "ID of Mars Rover: \(roverPhoto?.id ?? 0)"
        dateOfPhoto.text = "Date of photo: \(roverPhoto?.earth_date ?? "")"
        
        //передаем изображения
        //картинки могут грузиться позже, и чтобы не тормозить весь интерфейс, мы переключаем загрузку картинки в глобальный поток
        DispatchQueue.global().async {
            //создаем url адрес
            guard let url = URL(string: roverPhoto?.img_src ?? "") else { return }
            //пытаемся загрузить картинку
            guard let imageData = try? Data(contentsOf: url) else { return }
            //переключаемся на основной поток
            DispatchQueue.main.async {
                //инициализируем картинку
                self.roverImage.image = UIImage(data: imageData)
            }
        }
    }
}
