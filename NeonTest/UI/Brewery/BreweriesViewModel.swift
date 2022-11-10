//
//  BreweriesViewModel.swift
//  NeonTest
//
//  Created by Sean Tee on 08/11/2022.
//  Copyright © 2022 Sean Tee. All rights reserved.
//

import Foundation
import Combine
class BreweriesViewModel:ObservableObject{
  private let url = "https://api.openbrewerydb.org/breweries"
  @Published var breweries: [Brewery] = []
  var cancellables = Set<AnyCancellable>()
  deinit{
    print("o11:deinit")

  }

  func fetch(){
    URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
      .tryMap() {
        guard $0.data.count > 0 else { throw URLError(.zeroByteResource) }
        return $0.data
    }
    .decode(type: [Brewery].self, decoder: JSONDecoder())
    .eraseToAnyPublisher()
    .receive(on:DispatchQueue.main)
    .sink(receiveCompletion: { result in
      print(result)
      
    }, receiveValue: { breweries in
      self.breweries = breweries
      
    }).store(in: &cancellables)
  }
}
