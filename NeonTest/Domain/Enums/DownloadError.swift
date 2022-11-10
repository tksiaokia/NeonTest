//
//  DownloadError.swift
//  NeonTest
//
//  Created by Sean Tee on 09/11/2022.
//  Copyright © 2022 Sean Tee. All rights reserved.
//

import Foundation

enum DownloadError:Error{
  case urlEmpty
  case fileDownloaded
}
extension DownloadError:LocalizedError{
  public var errorDescription: String?{
    switch self{
    case.urlEmpty:
      return NSLocalizedString("Url cannot be empty", comment: "")
    case.fileDownloaded:
      return NSLocalizedString("File downloaded", comment: "")
    }
  }
}
