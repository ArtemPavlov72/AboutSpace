//
//  MainViewController.swift
//  AboutSpace
//
//  Created by Павлов Артем on 14.10.2021.
//

import UIKit

//каждый кейс - это отдельная кнопка на экране
//Подписываем под CaseIterable, чтобы нам были доступны все case из enum
enum UserAction: String, CaseIterable {
    case downloadImage = "NASA photo"
    case marsRoverPhotos = "Mars Rover photos"
}

class MainViewController: UICollectionViewController {

    //создаем неизменяемый массив со всеми кнопками. Чтобы в ручную не перечислять все case, мы подписываем UserAction под протокол CaseIterable, и нам становится доступным allCases
    let userActions = UserAction.allCases


    // MARK: UICollectionViewDataSource
    // настраиваем экран с ячейками
    //количество секций
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }
    
    //настраиваем саму ячейку
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // кастим до нашей созданной ячейки UserActionCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UserActionCell
        //передаем названия кейсов в лейбл ячейки
        cell.userLabel.text = userActions[indexPath.item].rawValue
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    //метод благодаря которому наши ячейки превращаются в кнопки
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       //определяем какую кнопку нажал пользователь, и в зависимости от этого переходим по нужному сигвею
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        case .downloadImage:
            performSegue(withIdentifier: "showImage", sender: nil)
        case .marsRoverPhotos:
            performSegue(withIdentifier: "roverSeg", sender: nil)
        }
    }
  
    // MARK: - Navigation
    //метод prepare будет вызываться при любом переходе по любому сигвею, поэтому необходимо указать условие, по какому из сигвею нужно вызывать данный метод
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "roverSeg" {
            guard let roverPhotoVC = segue.destination as? RoverPhotoViewController
            else {return}
            roverPhotoVC.fetchRoverPhotos()
        }
    }

}

//Протокол для настройки размеров ячейки в зависимости от экрана устройства. В отличие от tableView в collectionView это необходимо настраивать в ручную
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100) //ширину настраиваем через UIScreen, -48 это величина отступа от границ экрана
    }
}
