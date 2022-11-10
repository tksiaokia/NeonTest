//
//  DownloadRepo.swift
//  NeonTest
//
//  Created by Sean Tee on 09/11/2022.
//  Copyright © 2022 Sean Tee. All rights reserved.
//

import Foundation
import Digger
import Combine
protocol IDownloadRepo{
  func downloadFile(url:String,description:String,contentType:DownloadContentType)-> AnyPublisher<(Double,String?), Error>
  func cancelDownload(url:String)
  func getDownloadedList() -> [DownloadFile]
}

class DownloadRepo{
  private func storeDownloadRecord(url:String,description:String,contentType:DownloadContentType){
    var list  = getDownloadedList()
    list.append(DownloadFile(url: url, contentType: contentType, description: description))
    do {
      // Create JSON Encoder
      let encoder = JSONEncoder()
      
      // Encode Note
      let data = try encoder.encode(list)
      
      // Write/Set Data
      UserDefaults.standard.set(data, forKey: "files")
      
    } catch {
      print("Unable to Encode Array of Notes (\(error))")
    }
  }
  private func moveFileToLocalDirectory(url:URL)->String{
    do {
      let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true).first!
      let destPath = NSString(string:documentPath).appendingPathComponent(url.lastPathComponent)
      try FileManager.default.moveItem(at: url, to:  NSURL(fileURLWithPath: destPath) as URL)
      return destPath
    }
    catch let error as NSError {
      print("move file error: \(error.localizedDescription)")
    }
    return ""
  }
  
  
  
}
extension DownloadRepo:IDownloadRepo{
  func downloadFile(url: String, description: String, contentType: DownloadContentType) -> AnyPublisher<(Double, String?), Error> {
    let publisher = PassthroughSubject<(Double, String?), Error>()
    if(url.isEmpty){
      publisher.send(completion: .failure(DownloadError.urlEmpty))
    }else{
      Digger.download(url)
        .progress({ progress in
          publisher.send((progress.fractionCompleted,nil))
        })
        .completion { [weak self] result in
          switch result {
          case .success(let url):
            publisher.send((1.0,url.absoluteString))
            publisher.send(completion: .finished)
            guard let self = self else {return}
            let storedUrl = self.moveFileToLocalDirectory(url: url)
            print(storedUrl)
            self.storeDownloadRecord(url: storedUrl, description: description, contentType: contentType)
          case .failure(let error):
            let code = (error as NSError).code
            if(code == 9982){
              publisher.send(completion: .failure(DownloadError.fileDownloaded))
            }else{
              publisher.send(completion: .failure(error))
            }
            
          }
        }
    }
    return publisher.eraseToAnyPublisher()
  }
  
  func cancelDownload(url: String) {
    DiggerManager.shared.cancelTask(for: url)
  }
  
  func getDownloadedList() -> [DownloadFile]{
    if let data = UserDefaults.standard.data(forKey: "files") {
      do {
        // Create JSON Decoder
        let decoder = JSONDecoder()
        
        // Decode Note
        let note = try decoder.decode([DownloadFile].self, from: data)
        return note
        
      } catch {
        
        print("Unable to Decode Note (\(error))")
      }
    }
    return []
  }
  
}
