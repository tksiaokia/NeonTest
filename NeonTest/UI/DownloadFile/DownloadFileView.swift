//
//  DownloadFileView.swift
//  NeonTest
//
//  Created by Sean Tee on 08/11/2022.
//  Copyright © 2022 Sean Tee. All rights reserved.
//

import SwiftUI


struct DownloadFileView: View {
  @Environment(\.presentationMode) var presentation

  @State private var url: String = ""
  
  @State private var description: String = ""
  @State private var selectedContentType: String = "Image"
  let contentTypes = DownloadContentType.allCases.map({$0.rawValue})
  @ObservedObject var viewModel = DownloadFileViewModel()
  
  init(){
    print("------")
  }
  var body: some View {
    VStack{
      Form{
        if(viewModel.isDownloading){
          ProgressView("Downloading…\(Int(round(viewModel.downloadProgress*100)))%", value: viewModel.downloadProgress, total: 1)
        }
        else{
          Section(header: Text("URL") ) {
            TextField("https://", text: $url)
          }
          Section(header: Text("Description") ) {
            TextField("", text: $description)
          }
          Section(header:Text("Content Type")) {
            if #available(iOS 14.0, *) {
              Picker("Content Type", selection: $selectedContentType) {
                ForEach(contentTypes, id: \.self) {
                  Text($0)
                }
              }.pickerStyle(.menu)
            } else {
              // Fallback on earlier versions
            }
          }
          Button("Download"){
            if let contentType = DownloadContentType.init(rawValue: selectedContentType){
              viewModel.downloadFile(url: url, description: description, contentType:contentType)
            }
          }
        }
      }
      
    }
    .errorAlert(error: $viewModel.error,success: $viewModel.downloadSuccess){
      self.presentation.wrappedValue.dismiss()
    }
    .navigationBarTitle("Download File")
    
  }
}

struct DownloadFileView_Previews: PreviewProvider {
  static var previews: some View {
    DownloadFileView()
  }
}
