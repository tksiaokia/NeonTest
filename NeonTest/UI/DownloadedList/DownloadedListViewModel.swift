//
//  DownloadedListViewModel.swift
//  NeonTest
//
//  Created by Sean Tee on 09/11/2022.
//  Copyright © 2022 Sean Tee. All rights reserved.
//

import Foundation
import Combine
class DownloadListViewModel:ObservableObject{
  @Published var downloadFiles: [DownloadFile] = []
  init(){
    downloadFiles = DownloadRepo().getDownloadedList()
  }

}
