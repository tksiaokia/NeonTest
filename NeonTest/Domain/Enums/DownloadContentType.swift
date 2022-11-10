//
//  DownloadContentType.swift
//  NeonTest
//
//  Created by Sean Tee on 08/11/2022.
//  Copyright © 2022 Sean Tee. All rights reserved.
//

import Foundation
enum DownloadContentType:String,Codable,CaseIterable{
  case image = "Image"
  case pdf = "PDF"
  case video = "Video"
  case audio = "Audio"
}
