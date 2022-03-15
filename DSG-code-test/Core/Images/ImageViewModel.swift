//
//  ImageViewModel.swift
//  DSG-code-test
//
//  Created by Adam Reed on 3/14/22.
//

import Foundation
import SwiftUI
import Combine

class ImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private var imageURL: String
    private var imageName: String
    
    private let imageService: ImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(imageURL: String, imageName: String) {
        self.imageURL = imageURL
        self.imageName = imageName
        self.imageService = ImageService(imageURL: imageURL, imageName: imageName)
        self.addSubcribers()
        self.isLoading = true
    }
    
    private func addSubcribers() {
        imageService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellables)

    }
    
}
