//
//  PDFViewer.swift
//  NeonTest
//
//  Created by Sean Tee on 10/11/2022.
//  Copyright © 2022 Sean Tee. All rights reserved.
//

import SwiftUI
import PDFKit
struct PDFKitRepresentedView: UIViewRepresentable {
  let url: URL
  
  init(_ url: URL) {
    self.url = url
  }
  
  func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
    // Create a `PDFView` and set its `PDFDocument`.
    let pdfView = PDFView()
    pdfView.document = PDFDocument(url: self.url)
    return pdfView
  }
  
  func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
    // Update the view.
  }
}
struct PDFViewer: View {
  private let file: DownloadFile
  
  init(file: DownloadFile) {
    self.file = file
  }
  
  var body: some View {
    if let url = file.getFileUrl(){
      PDFKitRepresentedView(url)
        .edgesIgnoringSafeArea(.all)
        .navigationTitle(file.getFileName())
    }
  }
  
}
