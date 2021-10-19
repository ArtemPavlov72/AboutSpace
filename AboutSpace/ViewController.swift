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
        //создаем экземпляр класса URL, вставляем нашу ссылку
        guard let url = URL(string: Link.imageURL.rawValue) else { return }
        // создаем сетевой запрос через синглтон URLSession, вызываем метод URLSession и говорим по какому url делать запрос
        // data - нужная информация, urlrespinse - метоинформация от сервера, error - ошибка, ее всегда надо обрабатывать
        // в этом месте уходим в фоновый поток
        URLSession.shared.dataTask(with: url) { data, response, error in
            //дальше извлекаем данные, и если не сможем извлечь, то попытаемся извлечь объект ошибки, и если это не получилось, то выводим на консоль "No error description"
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            print(response)
            
            //создаем изображение
            guard let image = UIImage(data: data) else {return}
            //идем в главный поток асинхронно, т.е. без очереди (парралельно с теми задачами, что происходят в потоке
            DispatchQueue.main.async {
            //передаем изображение
            self.imageView.image = image
            //останавливаем ромашку
            self.activityIndicator.stopAnimating()
            //вызываем метод resume, означаем, что как только данные будут получены, мы начинаем с ними работать
            }
        }.resume()
        
    }
    
}

