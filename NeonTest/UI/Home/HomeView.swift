//
//  HomeView.swift
//  NeonTest
//
//  Created by Sean Tee on 08/11/2022.
//  Copyright © 2022 Sean Tee. All rights reserved.
//

import SwiftUI
struct HomeView: View {
  @State var screenIndex:Int?
  
  var body: some View {
    NavigationView {
      VStack(spacing:10){
        NavigationLink("Download File",
                       tag:0,
                       selection: self.$screenIndex,
                       destination:  {  DownloadFileView() }
        )
        NavigationLink("View List",
                       tag:1,
                       selection: self.$screenIndex,
                       destination:  {  DownloadedListView() }
        )
      }.navigationBarTitle("Home")
    }.navigationViewStyle(.stack)
    
    
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
