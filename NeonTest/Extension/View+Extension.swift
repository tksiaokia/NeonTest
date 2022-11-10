//
//  View+Extension.swift
//  NeonTest
//
//  Created by Sean Tee on 09/11/2022.
//  Copyright © 2022 Sean Tee. All rights reserved.
//

import Foundation
import SwiftUI
extension View {
  func errorAlert(error: Binding<String?>, success: Binding<String?>? = nil, buttonTitle: String = "OK",onDimiss: @escaping ()->Void) -> some View {
    return alert(isPresented: .constant(error.wrappedValue != nil || success?.wrappedValue != nil)){
      Alert(
        title:Text(""),
        message: Text(error.wrappedValue ?? success?.wrappedValue ?? ""),
        dismissButton: .default(Text(buttonTitle), action: {
          error.wrappedValue = nil
          if(success != nil && success?.wrappedValue != nil){
            onDimiss()
            success?.wrappedValue = nil

          }
        })
      )
    }
  }
}
