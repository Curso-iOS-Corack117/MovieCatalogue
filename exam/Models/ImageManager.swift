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
    @Published var backdrop: UIImage? = UIImage()
    
    init(imageName: String) {
        self.loadImage(imageName: imageName)
    }
    
    init(backdropName: String) {
        self.loadBackdrop(backdropName: backdropName)
    }
    
    init(imageName: String, backdropName:String) {
        self.loadImage(imageName: imageName)
        self.loadBackdrop(backdropName: backdropName)
    }
    
    func loadBackdrop(backdropName: String) {
        if let storedImage = userDefaults.data(forKey: backdropName) {
            backdrop = UIImage(data: storedImage)
            return
        }
        downloadImage(imageName: backdropName, isBackdrop: true)
    }
    
    func loadImage(imageName: String) {
        if let storedImage = userDefaults.data(forKey: imageName) {
            image = UIImage(data: storedImage)
            return
        }
        downloadImage(imageName: imageName, isBackdrop: false)
    }
    
    func downloadImage(imageName: String, isBackdrop: Bool) {
        let imageUrl = isBackdrop ? K.baseUrlBackdropImage : K.baseUrlImage
        if let url = URL(string: imageUrl + imageName) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, urlResponse, error in
                if let e = error {
                    print(e.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    let image = UIImage(data: data!)
                    self.userDefaults.set(data!, forKey: imageName)
                    if isBackdrop {
                        self.backdrop = image
                        return
                    }
                    self.image = image
                }
            }
            task.resume()
        }
    }
}
