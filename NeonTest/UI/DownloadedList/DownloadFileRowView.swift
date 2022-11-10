//
//  DownloadFileRowView.swift
//  NeonTest
//
//  Created by Sean Tee on 09/11/2022.
//  Copyright © 2022 Sean Tee. All rights reserved.
//

import SwiftUI

struct DownloadFileRowView: View {
  private let file: DownloadFile
  init(file: DownloadFile) {
    self.file = file
  }
  var body: some View {
    HStack(spacing:10){
      VStack(alignment: .leading, spacing: 15){
        Text(file.getFileName())
          .font(.system(size:18))
        Text(file.contentType?.rawValue ?? "")
          .foregroundColor(Color.gray)
          .font(.system(size: 14))
        Text(file.description ?? "")
          .foregroundColor(Color.gray)
          .font(.system(size: 14))
      }
      Spacer()
      viewButton
      
    }
  }
  
  @ViewBuilder
  var viewButton : some View {
    if let destination = self.getDestination(){
       NavigationLink {
        destination
      } label: {
        Text("VIEW")
          .foregroundColor(Color.blue)
          .font(.system(size: 20))
          .buttonStyle(PlainButtonStyle())
      }
    }else{
       Text("-")
        .foregroundColor(Color.blue)
        .font(.system(size: 20))
        .buttonStyle(PlainButtonStyle())
    }
  }
  
  func getDestination() ->  AnyView?{
    switch(file.contentType){
    case .image:
      return AnyView(MyImageViewer(file: file))
    case .none:
      return  nil
    case .some(.pdf):
      return  AnyView(PDFViewer(file: file))
    case .video,.audio:
      return AnyView(PlayerView(file: file))
    }
  }
 
}
struct DownloadFileRowView_Previews: PreviewProvider {
  static var previews: some View {
    DownloadFileRowView(file: DownloadFile(url: "file://aas/aa.mp4",contentType: DownloadContentType.image,description: "yoyoyyoy"))
  }
}

