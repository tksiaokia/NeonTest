//
//  DownloadFileViewModel.swift
//  NeonTest
//
//  Created by Sean Tee on 08/11/2022.
//  Copyright © 2022 Sean Tee. All rights reserved.
//

import Foundation
import Combine
class DownloadFileViewModel:ObservableObject{
  @Published private(set) var downloadProgress:Double = 0
  @Published private(set) var isDownloading:Bool = false
  @Published var error: String?
  @Published var downloadSuccess: String?

  
  var cancellables: [AnyCancellable] = []
  
  let progressSubject = PassthroughSubject<Double,Never>()
  
  
  init() {
    print("o00o:111")
    //
    //     self.progressSubject
    //       .assign(to: \.self.downloadProgress, on: self)
    //       .store(in: &cancellables)
  }
  deinit{
    print("o11:deinit")
    
  }
  
  func downloadFile(url:String,description:String,contentType:DownloadContentType){
    let repo = DownloadRepo()
    print(repo.getDownloadedList())
    repo.downloadFile(url: url, description: description, contentType: contentType)
      .receive(on: DispatchQueue.main)
      .handleEvents(receiveCancel:{
        repo.cancelDownload(url: url)
      })
      .sink(receiveCompletion: { [weak self]  completion in
        switch completion {
        case .failure(let err):
          self?.error = err.localizedDescription
        case .finished:
          self?.downloadSuccess = "Download Success"
        }
        print(completion)
      }, receiveValue: { [weak self] (progress,url) in
        guard let self = self else {return}
        if(!self.isDownloading){
          self.isDownloading = true
        }
        print("\(progress)")
        self.downloadProgress = progress
      })
      .store(in: &cancellables)
    
  }
}
