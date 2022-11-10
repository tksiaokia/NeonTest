//
//  DownloadFile.swift
//  NeonTest
//
//  Created by Sean Tee on 08/11/2022.
//  Copyright © 2022 Sean Tee. All rights reserved.
//

import Foundation
struct DownloadFile:Hashable,Codable {
  let url: String?
  let contentType: DownloadContentType?
  let description: String?
  
  func getFileName()->String{
    return (self.url as NSString?)?.lastPathComponent ?? ""
  }
  
  func getFileUrl()->URL?{
    guard let url = url  else {return nil}
    return NSURL(fileURLWithPath: url) as URL
    
  }
}
