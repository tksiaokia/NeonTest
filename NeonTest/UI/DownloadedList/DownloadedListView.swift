//
//  DownloadedListView.swift
//  NeonTest
//
//  Created by Sean Tee on 09/11/2022.
//  Copyright © 2022 Sean Tee. All rights reserved.
//

import SwiftUI

struct DownloadedListView: View {
  @ObservedObject var viewModel = DownloadListViewModel()
  var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 1)
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns,spacing:10) {
        ForEach(viewModel.downloadFiles,id:\.self){ file in
          DownloadFileRowView(file:file)
          RoundedRectangle(cornerRadius: 1)
            .foregroundColor( Color( .gray) )
            .frame(height: 1)
        }
      }.padding()
    }.navigationBarTitle("Downloaded Files", displayMode: .inline)
  }
}

struct DownloadedListView_Previews: PreviewProvider {
  static var previews: some View {
    DownloadedListView()
  }
}
