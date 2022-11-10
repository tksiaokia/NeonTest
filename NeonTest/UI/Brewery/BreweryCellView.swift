//
//  BreweryCellView.swift
//  NeonTest
//
//  Created by Sean Tee on 08/11/2022.
//  Copyright © 2022 Sean Tee. All rights reserved.
//

import SwiftUI

struct BreweryCellView: View {
  private let brewery: Brewery
  init(brewery: Brewery) {
    self.brewery = brewery
  }
  
  var body: some View {
    HStack{
      VStack(alignment: .leading, spacing: 15){
        Text(brewery.name ?? "")
          .font(.system(size:18))
          .foregroundColor(Color.blue)
        Text("\(brewery.city ?? "" ) - \(brewery.street ?? "")")
          .font(.system(size: 14))
      }
    }
  }
}

