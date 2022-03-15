//
//  ImageView.swift
//  DSG-code-test
//
//  Created by Adam Reed on 3/14/22.
//

import SwiftUI

struct ImageView: View {
    
    @StateObject var vm: ImageViewModel
    
    init(imageURL: String, imageName: String) {
        _vm = StateObject(wrappedValue: ImageViewModel(imageURL: imageURL, imageName: imageName))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
  
            } else if vm.isLoading {
               ProgressView()
            } else {
                Image(systemName: "questionmark")
                
                    
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageURL: "https://seatgeek.com/images/performers-landscape/swdca-youth-wrestling-5d58d1/793204/huge.jpg", imageName: "")
    }
}
