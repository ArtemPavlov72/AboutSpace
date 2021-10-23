//
//  RoverPhotoViewController.swift
//  AboutSpace
//
//  Created by iMac on 20.10.2021.
//

import UIKit

class RoverPhotoViewController: UITableViewController {

    private var roverPhoto: RoverPhoto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 120
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        roverPhoto?.photos?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //кастим до нашей кастомной ячейки RoverPhotoCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RoverPhotoCell
        let roverPhoto = roverPhoto?.photos?[indexPath.row]
        //вызываем метод configure, который мы сделали в RoverPhotoCell
        cell.configure(with: roverPhoto)
        return cell
    }
}
// MARK: - Networking
extension RoverPhotoViewController {
    func fetchRoverPhotos() {
        NetworkManager.shared.fetch(dataType: RoverPhoto.self, from: Link.marsRoverPhotos.rawValue, convertFromSnakeCase: true) { result in
            switch result {
            case.success(let photo):
                self.roverPhoto = photo
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}


