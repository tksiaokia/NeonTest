//
//  ImageViewer.swift
//  NeonTest
//
//  Created by Sean Tee on 10/11/2022.
//  Copyright © 2022 Sean Tee. All rights reserved.
//

import SwiftUI
import ImageViewer
struct MyImageViewer: View {
  @State var image:UIImage? = UIImage(named:"")
  private let file: DownloadFile
  
  init(file: DownloadFile) {
    self.file = file
  }
  
  var body: some View {
    VStack {
      if let image = self.image{
        Image(uiImage: image)
          .resizable()
          .aspectRatio(contentMode: .fit)
      }
    }
    .edgesIgnoringSafeArea(.all)
    .navigationTitle(file.getFileName())
    .onAppear(perform: {
      do {
        let url =  NSURL(fileURLWithPath: file.url ?? "" ) as? URL
        
        let imageData = try Data(contentsOf: url!)
        image = UIImage(data: imageData)
      } catch {
        print("Error loading image : \(error)")
      }
    })
  }
}


