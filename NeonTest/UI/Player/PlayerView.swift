//
//  PlayerView.swift
//  NeonTest
//
//  Created by Sean Tee on 09/11/2022.
//  Copyright © 2022 Sean Tee. All rights reserved.
//

import SwiftUI
import AVKit
struct PlayerView: View {
  private let file: DownloadFile
  @State  private var player:AVPlayer = AVPlayer()
  
  init(file: DownloadFile) {
    self.file = file
  }
  
  var body: some View {
    VideoPlayer(player: player)
      .edgesIgnoringSafeArea(.all)
      .navigationTitle(file.getFileName())
      .onAppear{
        if let url = file.getFileUrl(){
          player = AVPlayer(url:url)
          player.play()
        }
      }
  }
}


