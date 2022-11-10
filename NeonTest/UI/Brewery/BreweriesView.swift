//
//  BreweriesView.swift
//  NeonTest
//
//  Created by Sean Tee on 08/11/2022.
//  Copyright © 2022 Sean Tee. All rights reserved.
//

import SwiftUI

struct BreweriesView: View {
  @ObservedObject var viewModel = BreweriesViewModel()
  
  var body: some View {
      List(viewModel.breweries,id:\.self){ brewery in
        BreweryCellView(brewery: brewery)
      }.navigationBarTitle("Oceans")
        .onAppear{
          self.viewModel.fetch()
      }
    }
  
}

struct BreweriesView_Previews: PreviewProvider {
    static var previews: some View {
        BreweriesView()
    }
}
