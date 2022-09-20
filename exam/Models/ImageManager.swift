//
//  ImageManager.swift
//  exam
//
//  Created by Sergio Ordaz Romero on 16/09/22.
//

import Foundation
import UIKit

class ImageManager: ObservableObject {
    private var userDefaults: UserDefaults = .standard
    @Published var image: UIImage? = UIImage()
    
    init(imageName: String) {
        self.loadImage(imageName: imageName)
    }
    
    func loadImage(imageName: String) {
        if let storedImage = userDefaults.data(forKey: imageName) {
            image = UIImage(data: storedImage)
            return
        }
        downloadImage(imageName: imageName)
    }
    
    func downloadImage(imageName: String) {
        if let url = URL(string: K.baseUrlImage + imageName) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, urlResponse, error in
                if let e = error {
                    print(e.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    let image = UIImage(data: data!)
                    self.userDefaults.set(data!, forKey: imageName)
                    self.image = image
                }
            }
            task.resume()
        }
    }
}
