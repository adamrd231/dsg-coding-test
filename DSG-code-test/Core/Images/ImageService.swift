//
//  ImageViewModel.swift
//  DSG-code-test
//
//  Created by Adam Reed on 3/14/22.
//

import Foundation
import SwiftUI
import Combine

class ImageService: ObservableObject {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let fileManager = LocalFileManager.instance
    private let folderName = "nft_images"
    private let imageName: String
    private let imageURL: String
    
    init(imageURL: String, imageName: String) {
        self.imageURL = imageURL
        self.imageName = imageName
        getImage()
    }
    
    func getImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
        } else {
            downloadImage()
        }
    }
    
    func downloadImage() {
        
        guard let url = URL(string: imageURL) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
                self.imageSubscription?.cancel()
            })
    }
}
